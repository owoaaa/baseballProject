package kr.swj.baseball.main.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MlbTeamRank {
    private String teamName;
    private int wins;
    private int losses;
    
    private String divisionName;
    private double gamesBack;

}