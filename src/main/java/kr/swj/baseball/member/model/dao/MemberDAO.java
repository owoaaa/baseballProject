package kr.swj.baseball.member.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.swj.baseball.member.model.dto.Member;

@Repository
public class MemberDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public Member selectById(String memberId) {
        return sqlSession.selectOne("memberMapper.selectById", memberId);
    }
	
	public int insertMember(Member member) {
	    return sqlSession.insert("memberMapper.insertMember", member);
	}
	
	public int checkId(String memberId) {
	    return sqlSession.selectOne("memberMapper.checkId", memberId);
	}
	
	public int checkNick(String memberNick) {
	    return sqlSession.selectOne("memberMapper.checkNick", memberNick);
	}

}
