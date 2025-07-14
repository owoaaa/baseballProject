package kr.swj.baseball.board.model.dto;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Reply {
    private int replyNo;
    private String replyContent;
    private Date replyCreateDate;

    // 댓글이 달린 게시글 정보
    private Board board;
}
