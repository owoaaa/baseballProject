package kr.swj.baseball.member.controller;

import java.util.List;

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
	public String myPage() {
		return "member/myPage";
	}
	
	@GetMapping("/test-insert")
	@ResponseBody
	public String testInsertTeam() {
	    int result = teamService.insertTestKboTeam();
	    return "삽입 결과: " + result;
	}

}
