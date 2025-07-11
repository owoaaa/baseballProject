package kr.swj.baseball.team.model.service;

import java.util.List;

import kr.swj.baseball.team.model.dto.Team;

public interface TeamService {
	
	List<Team> selectKboTeamList();
    List<Team> selectMlbTeamList();
    int insertTestKboTeam();

}
