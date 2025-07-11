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
	private Date createDate;
	private Date updateDate;
	private String memberNickname;
	private int replyCount;
	private int likeCount;

}
