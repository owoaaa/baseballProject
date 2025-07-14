package kr.swj.baseball.member.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

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

import kr.swj.baseball.board.model.dto.Board;
import kr.swj.baseball.board.model.dto.PageInfo;
import kr.swj.baseball.board.model.dto.Reply;
import kr.swj.baseball.board.model.service.BoardService;
import kr.swj.baseball.member.model.dto.Member;
import kr.swj.baseball.member.model.service.MemberService;
import kr.swj.baseball.team.model.dto.Team;
import kr.swj.baseball.team.model.service.TeamService;


@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	private MemberService service;
	
	@Autowired
	private TeamService teamService;
	
	@Autowired
	private BoardService boardService;
	
	@GetMapping("/login")
	public String login() {
		return "member/login";
	}
	
	@PostMapping("/login")
	public String login(@RequestParam("memberId") String memberId,
	                    @RequestParam("memberPw") String memberPw,
	                    HttpSession session,
	                    Model model) {

	    Member inputMember = new Member();
	    inputMember.setMemberId(memberId);
	    inputMember.setMemberPw(memberPw);

	    Member loginMember = service.login(inputMember);

	    if (loginMember != null) {
	        session.setAttribute("loginMember", loginMember);
	        return "redirect:/";
	    } else {
	        model.addAttribute("loginFailed", true);
	        return "redirect:/?showLoginModal=true&error=1";
	    }
	}
	
	// 로그아웃
	@GetMapping("/logout")
	public String logout(HttpSession session) {
	    session.invalidate(); // 세션 제거
	    return "redirect:/";  // 메인페이지로 이동
	}
	
	// 회원가입 페이지 이동
	@GetMapping("/signUp")
	public String signUp(Model model) {

	    List<Team> kboTeamList = teamService.selectKboTeamList();
	    System.out.println("KBO 조회 결과 수: " + kboTeamList.size());
	    for (Team t : kboTeamList) {
	        System.out.println(t);
	    }
	    List<Team> mlbTeamList = teamService.selectMlbTeamList();

	    model.addAttribute("kboTeamList", kboTeamList);
	    model.addAttribute("mlbTeamList", mlbTeamList);

	    System.out.println("kboTeamList = " + kboTeamList);
	    System.out.println("mlbTeamList = " + mlbTeamList);

	    return "member/signUp";
	}
	
	// 회원 가입 기능
	@PostMapping("/signUp")
	public String signUp(@ModelAttribute Member inputMember,
	                     RedirectAttributes ra) {

	    int result = service.signUp(inputMember);

	    if (result > 0) {
	        ra.addFlashAttribute("message", "회원가입 성공! 로그인 해주세요.");
	        return "redirect:/";
	    } else {
	        ra.addFlashAttribute("message", "회원가입 실패. 다시 시도해주세요.");
	        return "redirect:/member/signUp";
	    }
	}
	// 아이디 중복검사
	@GetMapping("/checkId")
	@ResponseBody
	public String checkId(@RequestParam("memberId") String memberId) {
	    int result = service.checkId(memberId);
	    return String.valueOf(result); // 0: 사용가능, 1: 중복
	}
	
	// 닉네임 중복 검사
	@GetMapping("/checkNick")
	@ResponseBody
	public String checkNick(@RequestParam("memberNick") String memberNick) {
	    int result = service.checkNick(memberNick);
	    return String.valueOf(result);
	}
	
	@GetMapping("/myPage")
	public String myPage(HttpSession session, Model model) {
	    Member loginMember = (Member) session.getAttribute("loginMember");

	    // DB에서 최신 회원 정보 조회
	    Member updatedMember = service.selectMemberByNo(loginMember.getMemberNo());

	    // KBO / MLB 팀 목록 추가 조회
	    List<Team> kboTeamList = teamService.selectKboTeamList();
	    List<Team> mlbTeamList = teamService.selectMlbTeamList();

	    // 최근 게시글/댓글 5개 조회 (BoardService에서 가져옴)
	    List<Board> recentBoards = boardService.selectRecentBoards(updatedMember.getMemberNo());
	    List<Reply> recentReplies = boardService.selectRecentReplies(updatedMember.getMemberNo());

	    // model에 모두 담기
	    model.addAttribute("loginMember", updatedMember);
	    model.addAttribute("kboTeamList", kboTeamList);
	    model.addAttribute("mlbTeamList", mlbTeamList);
	    model.addAttribute("recentBoards", recentBoards);
	    model.addAttribute("recentReplies", recentReplies);

	    return "member/myPage";
	}
	
	// 마이페이지 정보 수정
	@PostMapping("/updateInfo")
	public String updateInfo(@ModelAttribute Member inputMember, HttpSession session, RedirectAttributes ra) {

	    Member loginMember = (Member) session.getAttribute("loginMember");

	    boolean isKboChanged = inputMember.getKboTeamNo() != loginMember.getKboTeamNo();
	    boolean isMlbChanged = inputMember.getMlbTeamNo() != loginMember.getMlbTeamNo();

	    if (!isKboChanged && !isMlbChanged) {
	        ra.addFlashAttribute("message", "변경된 사항이 없습니다.");
	        ra.addFlashAttribute("messageType", "error"); // 빨간색
	        return "redirect:/member/myPage";
	    }

	    inputMember.setMemberNo(loginMember.getMemberNo());

	    int result = service.updateTeamInfo(inputMember);

	    if (result > 0) {
	        ra.addFlashAttribute("message", "응원 팀이 수정되었습니다.");
	        ra.addFlashAttribute("messageType", "success"); // 초록색
	        loginMember.setKboTeamNo(inputMember.getKboTeamNo());
	        loginMember.setMlbTeamNo(inputMember.getMlbTeamNo());
	    } else {
	        ra.addFlashAttribute("message", "수정 실패. 다시 시도해주세요.");
	        ra.addFlashAttribute("messageType", "error"); // 빨간색
	    }

	    return "redirect:/member/myPage";
	}
	
	
	@GetMapping("/myPosts")
	public String getMyPosts(@RequestParam(defaultValue = "1") int cp, HttpSession session, Model model) {
	    Member loginMember = (Member) session.getAttribute("loginMember");

	    int listCount = boardService.getMyPostCount(loginMember.getMemberNo());
	    PageInfo pi = new PageInfo(listCount, cp, 10, 10);

	    List<Board> boardList = boardService.getMyPostList(loginMember.getMemberNo(), pi);

	    model.addAttribute("boardList", boardList);
	    model.addAttribute("pi", pi);

	    return "board/myPostTable";
	}

	@GetMapping("/myReplies")
	public String getMyReplies(@RequestParam(defaultValue = "1") int cp, HttpSession session, Model model) {
	    Member loginMember = (Member) session.getAttribute("loginMember");

	    int listCount = boardService.getMyReplyCount(loginMember.getMemberNo());
	    PageInfo pi = new PageInfo(listCount, cp, 10, 10);

	    List<Reply> replyList = boardService.getMyReplyList(loginMember.getMemberNo(), pi);

	    model.addAttribute("replyList", replyList);
	    model.addAttribute("pi", pi);

	    return "board/myReplyTable";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	@GetMapping("/test-insert")
	@ResponseBody
	public String testInsertTeam() {
	    int result = teamService.insertTestKboTeam();
	    return "삽입 결과: " + result;
	}

}
