package kr.swj.baseball.member.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.swj.baseball.common.Encryptor;
import kr.swj.baseball.member.model.dao.MemberDAO;
import kr.swj.baseball.member.model.dto.Member;

@Service
public class MemberServiceImpl implements MemberService{
	
	@Autowired
	private MemberDAO dao; 

	
	@Override
    public Member login(Member inputMember) {
        // 1. 아이디로 회원 조회
        Member dbMember = dao.selectById(inputMember.getMemberId());

        // 2. 비밀번호 암호화 비교
        if (dbMember != null && Encryptor.matches(inputMember.getMemberPw(), dbMember.getMemberPw())) {
            dbMember.setMemberPw(null); // 보안상 null 처리
            return dbMember;
        }

        return null;
    }
	
	@Override
	public int signUp(Member inputMember) {
		
		// 아이디 중복체크
	    if (dao.checkId(inputMember.getMemberId()) > 0) {
	        return 0; // 아이디 중복시 실패
	    }

	    // 닉네임 중복체크
	    if (dao.checkNick(inputMember.getMemberNick()) > 0) {
	        return 0; // 닉네임 중복시 실패
	    }

	    // 비밀번호 암호화
	    String encryptedPw = Encryptor.encode(inputMember.getMemberPw());
	    inputMember.setMemberPw(encryptedPw);

	    return dao.insertMember(inputMember);
	}
	
	// 아이디 중복검사
	@Override
	public int checkId(String memberId) {
	    return dao.checkId(memberId);
	}
	
	@Override
	public int checkNick(String memberNick) {
	    return dao.checkNick(memberNick);
	}
}
