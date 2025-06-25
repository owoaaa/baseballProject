package kr.swj.baseball.main.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.swj.baseball.member.model.service.MemberService;


@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	private MemberService service;
	
	@GetMapping("/login")
	public String login() {
		return "member/login";
	}
	
	@GetMapping("/signUp")
	public String signUp() {
		return "member/signUp";
	}

}
