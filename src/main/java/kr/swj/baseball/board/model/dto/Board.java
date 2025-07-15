package kr.swj.baseball.board.model.dto;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Board {
	
	private int boardNo;
	private String boardTitle;
	private String boardContent;
	private Date createDate;
	private Date updateDate;
	private String boardType;
	private int viewCount;
	private String boardSt;

	private int memberNo;        // 작성자 회원번호
	private String memberNick;

	private int replyCount;
	private int likeCount;

	private Integer mlbTeamNo;  
	private Integer kboTeamNo;
	
	

}
