package kr.swj.baseball.team.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.swj.baseball.team.model.dao.TeamDAO;
import kr.swj.baseball.team.model.dto.Team;

@Service
public class TeamServiceImpl implements TeamService{
	
	@Autowired
	private TeamDAO dao; 
	
	@Override
    public List<Team> selectKboTeamList() {
        return dao.selectKboTeamList();
    }

    @Override
    public List<Team> selectMlbTeamList() {
        return dao.selectMlbTeamList();
    }
    
    @Override
    public int insertTestKboTeam() {
        return dao.insertTestKboTeam();
    }

}
