package kr.swj.baseball.team.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.swj.baseball.team.model.dto.Team;

@Repository
public class TeamDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public List<Team> selectKboTeamList() {
        return sqlSession.selectList("teamMapper.selectKboTeamList");
    }

    public List<Team> selectMlbTeamList() {
        return sqlSession.selectList("teamMapper.selectMlbTeamList");
    }
    
    public int insertTestKboTeam() {
        return sqlSession.insert("teamMapper.testInsertKboTeam");
    }
	
	

}
