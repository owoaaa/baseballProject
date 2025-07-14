package kr.swj.baseball.member.model.service;

import kr.swj.baseball.member.model.dto.Member;

public interface MemberService {
	
	 Member login(Member inputMember);
	 
	 int signUp(Member inputMember);
	 
	 // 아이디 중복 검사
	 int checkId(String memberId);
	 // 닉네임 중복 검사
	 int checkNick(String memberNick);
	 // 마이페이지 이동
	 Member selectMemberByNo(int memberNo);
	 
	 // 마이페이지 정보 수정
	 int updateTeamInfo(Member member);

}
