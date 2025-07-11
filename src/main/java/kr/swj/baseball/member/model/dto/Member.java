package kr.swj.baseball.member.model.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Member {
	
	private int memberNo;
    private String memberId;
    private String memberPw;
    private String memberNick;
    private Integer kboTeamNo;
    private Integer mlbTeamNo;

}
