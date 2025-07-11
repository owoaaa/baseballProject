package kr.swj.baseball.main.dto;


import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class TeamRank {
    private int rank;
    private String teamName;
    private int games;
    private int wins;
    private int losses;
    private int draws;
    private String winRate;
    private String gap;
    private String last10;
    private String streak;
    private String home;
    private String away;
}