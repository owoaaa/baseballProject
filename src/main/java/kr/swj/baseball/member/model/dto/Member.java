package kr.swj.baseball.member.model.dto;

import java.util.Date;

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
    private String memberImage;
    private Date enrollDate;
    private String secessionFl;
    private int kboTeamNo;
    private int mlbTeamNo;

}
