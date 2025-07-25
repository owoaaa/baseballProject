package kr.swj.baseball.board.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.swj.baseball.board.model.dto.Board;
import kr.swj.baseball.board.model.dto.PageInfo;
import kr.swj.baseball.board.model.dto.Reply;
import kr.swj.baseball.board.model.service.BoardService;
import kr.swj.baseball.board.model.service.KboRankingService;
import kr.swj.baseball.board.model.service.KboStatService;
import kr.swj.baseball.board.model.service.MlbRankingService;
import kr.swj.baseball.main.dto.MlbTeamRank;
import kr.swj.baseball.main.dto.TeamRank;
import kr.swj.baseball.member.model.dto.Member;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	@Autowired
    private BoardService boardService;
	
	@Autowired
	private MlbRankingService mlbRankingService;
	
	@Autowired
	private KboRankingService kboRankingService;
	
	@Autowired
	private KboStatService kboStatService;
	
	@RequestMapping("/freeboard")
	public String freeboardList() {
	    return "board/freeboard";
	}
	

	// db 연동
	/*
	 * @RequestMapping("/freeboard") public String freeboardList(Model model) {
	 * List<Board> boardList = boardService.selectFreeBoardList();
	 * model.addAttribute("boardList", boardList); return "board/freeboard"; }
	 */

	@GetMapping("/mlbRecord")
	public String mlbPlayers(Model model) throws IOException {
	    List<Map<String, Object>> hitterList = new ArrayList<>();
	    List<Map<String, Object>> pitcherList = new ArrayList<>();

	    // 타자 기록
	    int offset = 0;
	    while (true) {
	        String apiUrl = "https://statsapi.mlb.com/api/v1/stats?stats=season&group=hitting&season=2025&limit=100&offset=" + offset;
	        HttpURLConnection conn = (HttpURLConnection) new URL(apiUrl).openConnection();
	        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	        StringBuilder sb = new StringBuilder(); String line;
	        while ((line = br.readLine()) != null) sb.append(line);
	        br.close();

	        JSONArray splits = new JSONObject(sb.toString())
	            .getJSONArray("stats").getJSONObject(0).getJSONArray("splits");

	        if (splits.length() == 0) break;

	        for (int i = 0; i < splits.length(); i++) {
	            JSONObject stat = splits.getJSONObject(i).getJSONObject("stat");
	            JSONObject player = splits.getJSONObject(i).getJSONObject("player");
	            Map<String, Object> row = new HashMap<>();
	            row.put("name", player.getString("fullName"));
	            row.put("avg", stat.optString("avg", "-"));
	            row.put("homeRuns", stat.optInt("homeRuns", 0));
	            row.put("rbi", stat.optInt("rbi", 0));
	            row.put("runs", stat.optInt("runs", 0));
	            row.put("hits", stat.optInt("hits", 0));
	            row.put("atBats", stat.optInt("atBats", 0));
	            row.put("baseOnBalls", stat.optInt("baseOnBalls", 0));
	            row.put("strikeOuts", stat.optInt("strikeOuts", 0));
	            row.put("stolenBases", stat.optInt("stolenBases", 0));
	            row.put("obp", stat.optString("obp", "-"));
	            row.put("slg", stat.optString("slg", "-"));
	            row.put("ops", stat.optString("ops", "-"));
	            row.put("doubles", stat.optInt("doubles", 0));
	            row.put("triples", stat.optInt("triples", 0));
	            row.put("plateAppearances", stat.optInt("plateAppearances", 0));
	            row.put("gamesPlayed", stat.optInt("gamesPlayed", 0));
	            row.put("sacFlies", stat.optInt("sacFlies", 0));
	            row.put("totalBases", stat.optInt("totalBases", 0));
	            row.put("groundOutsToAirouts", stat.optDouble("groundOutsToAirouts", 0));
	            hitterList.add(row);
	        }
	        offset += 100;
	    }

	    // 투수 기록 
	    offset = 0;
	    while (true) {
	    	String apiUrl = "https://statsapi.mlb.com/api/v1/stats?stats=season&group=pitching&season=2025&limit=100&offset=" + offset + "&qualified=false";
	        HttpURLConnection conn = (HttpURLConnection) new URL(apiUrl).openConnection();
	        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	        StringBuilder sb = new StringBuilder(); String line;
	        while ((line = br.readLine()) != null) sb.append(line);
	        br.close();

	        JSONArray splits = new JSONObject(sb.toString())
	            .getJSONArray("stats").getJSONObject(0).getJSONArray("splits");

	        if (splits.length() == 0) break;

	        for (int i = 0; i < splits.length(); i++) {
	            JSONObject stat = splits.getJSONObject(i).getJSONObject("stat");
	            JSONObject player = splits.getJSONObject(i).getJSONObject("player");
	            Map<String, Object> row = new HashMap<>();
	            row.put("name", player.getString("fullName"));
	            row.put("era", stat.optString("era", "-"));
	            row.put("gamesPlayed", stat.optInt("gamesPlayed", 0));
	            row.put("gamesStarted", stat.optInt("gamesStarted", 0));
	            row.put("wins", stat.optInt("wins", 0));
	            row.put("losses", stat.optInt("losses", 0));
	            row.put("saves", stat.optInt("saves", 0));
	            row.put("inningsPitched", stat.optString("inningsPitched", "-"));
	            row.put("strikeOuts", stat.optInt("strikeOuts", 0));
	            row.put("baseOnBalls", stat.optInt("baseOnBalls", 0));
	            row.put("hits", stat.optInt("hits", 0));
	            row.put("whip", stat.optString("whip", "-"));
	            pitcherList.add(row);
	        }
	        offset += 100;
	    }

	    model.addAttribute("mlbList", hitterList);
	    model.addAttribute("mlbPitchers", pitcherList);
	    return "board/mlbRecord";
	}
	
	// mlb 순위표
	@GetMapping("/mlbStanding")
	public String mlbStanding(Model model) {
		Map<String, List<MlbTeamRank>> mlbGroupedList;
		try {
			mlbGroupedList = mlbRankingService.getGroupedMlbRanking();
			model.addAttribute("mlbGroupedList", mlbGroupedList);
			model.addAttribute("contentPage", "/WEB-INF/views/board/mlbStanding.jsp");
		} catch (Exception e) {
			e.printStackTrace();
		}
	    return "common/layout";
	}
	
	// kbo 순위표
	@GetMapping("/kboStanding")
	public String kboStanding(Model model) {
		
		List<TeamRank> kboList;
		try {
			kboList = kboRankingService.getRanking();
			model.addAttribute("kboList", kboList);
			model.addAttribute("contentPage", "/WEB-INF/views/board/kboStanding.jsp");
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return "common/layout";
		
	}
	
	// kbo 선수 스탯
	@GetMapping("/kboRecord")
	public String kboRecord(Model model) {
	    try {
	        List<Map<String, Object>> kboHitters = kboStatService.getHitterStats();
	        List<Map<String, Object>> kboPitchers = kboStatService.getPitcherStats();

	        ObjectMapper mapper = new ObjectMapper();
	        String hittersJson = mapper.writeValueAsString(kboHitters);
	        String pitchersJson = mapper.writeValueAsString(kboPitchers);

	        model.addAttribute("kboHittersJson", hittersJson);
	        model.addAttribute("kboPitchersJson", pitchersJson);
	        System.out.println("타자 데이터 JSON: " + hittersJson);

	    } catch (IOException e) {
	        e.printStackTrace();
	    }

	    return "board/kboRecord";
	}
	
	@GetMapping("/list")
	public String boardList(@RequestParam("type") String boardType,
	                        @RequestParam(value = "page", defaultValue = "1") int currentPage,
	                        @RequestParam(value = "keyword", required = false) String keyword,
	                        Model model, HttpSession session) {

	    Member loginMember = (Member) session.getAttribute("loginMember");

	    // 검색 기록 저장
	    if (loginMember != null && keyword != null && !keyword.trim().isEmpty()) {
	        boardService.saveSearchHistory(loginMember.getMemberNo(), keyword);
	    }

	    int listCount = (keyword == null || keyword.trim().isEmpty()) 
	        ? boardService.getBoardCount(boardType)
	        : boardService.getSearchCount(boardType, keyword);

	    int pageLimit = 10;
	    int boardLimit = 10;

	    PageInfo pi = new PageInfo(listCount, currentPage, pageLimit, boardLimit);

	    List<Board> boardList = (keyword == null || keyword.trim().isEmpty())
	        ? boardService.selectBoardList(pi, boardType)
	        : boardService.searchBoardList(pi, boardType, keyword);

	    model.addAttribute("boardList", boardList);
	    model.addAttribute("pageInfo", pi);
	    model.addAttribute("boardType", boardType);
	    model.addAttribute("keyword", keyword);

	    return "board/board";
	}
	
	// 게시글 상세 페이지
	@GetMapping("/detail")
	public String boardDetail(@RequestParam("no") int boardNo, Model model, HttpSession session) {
	    Board board = boardService.selectBoardDetail(boardNo);
	    if (board == null) {
	        model.addAttribute("message", "게시글이 존재하지 않습니다.");
	        model.addAttribute("messageType", "error");
	        return "redirect:/board/list";
	    }

	    boardService.increaseViewCount(boardNo); // 조회수 증가

	    List<Reply> replyList = boardService.selectReplyList(boardNo);

	    model.addAttribute("board", board);
	    model.addAttribute("boardType", board.getBoardType());
	    model.addAttribute("replyList", replyList);
	    model.addAttribute("loginMember", (Member) session.getAttribute("loginMember"));

	    return "board/boardDetail";
	}
	
	// 좋아요 ajax
	@PostMapping("/like")
	@ResponseBody
	public Map<String, Object> toggleLike(@RequestParam("no") int boardNo,
	                                      @RequestParam("type") String boardType,
	                                      HttpSession session) {

	    Member loginMember = (Member) session.getAttribute("loginMember");
	    Map<String, Object> result = new HashMap<>();

	    if (loginMember == null) {
	        result.put("error", "unauthenticated");
	        return result;
	    }

	    int memberNo = loginMember.getMemberNo();

	    boolean liked = boardService.toggleLike(boardNo, memberNo); // true면 좋아요됨, false면 취소됨
	    int likeCount = boardService.getLikeCount(boardNo);

	    result.put("liked", liked);
	    result.put("likeCount", likeCount);
	    result.put("boardType", boardType);

	    return result;
	}
	
	// 게시글 작성 페이지 이동
	@GetMapping("/write")
	public String showWriteForm(@RequestParam String type, Model model) {
	    model.addAttribute("boardType", type);
	    return "board/boardWrite"; // boardWrite.jsp
	}
	
	// 게시글 작성
	@PostMapping("/write")
	public String insertBoard(@ModelAttribute Board board, HttpSession session, RedirectAttributes ra) {
	    Member loginMember = (Member) session.getAttribute("loginMember");

	    if (loginMember == null) {
	        ra.addFlashAttribute("message", "로그인 후 이용해주세요.");
	        ra.addFlashAttribute("messageType", "error");
	        return "redirect:/";
	    }

	    board.setMemberNo(loginMember.getMemberNo());

	    int result = boardService.insertBoard(board);

	    if (result > 0) {
	        ra.addFlashAttribute("message", "게시글이 등록되었습니다.");
	        return "redirect:/board/detail?no=" + board.getBoardNo(); // 또는 목록 페이지로 이동 가능
	    } else {
	        ra.addFlashAttribute("message", "게시글 등록 실패");
	        ra.addFlashAttribute("messageType", "error");
	        return "redirect:/board/write?type=" + board.getBoardType();
	    }
	}
	
	// 게시글 수정 페이지 이동
	@GetMapping("/edit")
	public String editForm(@RequestParam("no") int boardNo, Model model, HttpSession session, RedirectAttributes ra) {
	    Member loginMember = (Member) session.getAttribute("loginMember");
	    
	    // 로그인하지 않았거나 세션 없음
	    if (loginMember == null) {
	        ra.addFlashAttribute("message", "로그인 후 이용해주세요.");
	        return "redirect:/";
	    }

	    // 게시글 조회
	    Board board = boardService.selectBoardDetail(boardNo);

	    if (board == null || board.getBoardSt().equals("Y")) {
	        ra.addFlashAttribute("message", "게시글이 존재하지 않습니다.");
	        return "redirect:/board/list?type=FREE";
	    }

	    // 작성자 본인이 아닌 경우
	    if (board.getMemberNo() != loginMember.getMemberNo()) {
	        ra.addFlashAttribute("message", "수정 권한이 없습니다.");
	        return "redirect:/board/detail?no=" + boardNo;
	    }

	    model.addAttribute("board", board);
	    return "board/boardEdit";
	}
	
	// 게시글 수정 처리
	@PostMapping("/edit")
	public String editBoard(Board board, HttpSession session, RedirectAttributes ra) {
	    Member loginMember = (Member) session.getAttribute("loginMember");

	    if (loginMember == null) {
	        ra.addFlashAttribute("message", "로그인 후 이용해주세요.");
	        return "redirect:/";
	    }

	    board.setMemberNo(loginMember.getMemberNo());

	    int result = boardService.updateBoard(board);

	    if (result > 0) {
	        ra.addFlashAttribute("message", "게시글이 수정되었습니다.");
	        return "redirect:/board/detail?no=" + board.getBoardNo();
	    } else {
	        ra.addFlashAttribute("message", "게시글 수정에 실패했습니다.");
	        return "redirect:/board/edit?no=" + board.getBoardNo();
	    }
	}
	
	/** 최근 검색어 조회용
	 * @param session
	 * @return
	 */
	@GetMapping("/recentSearch")
	@ResponseBody
	public List<String> getRecentSearches(HttpSession session) {
	    Member loginMember = (Member) session.getAttribute("loginMember");
	    if (loginMember == null) return new ArrayList<>();

	    return boardService.getRecentSearches(loginMember.getMemberNo());
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}