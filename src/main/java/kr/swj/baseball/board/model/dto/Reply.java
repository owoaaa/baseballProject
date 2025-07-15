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
    private int boardNo;
    private int memberNo;

    private String replyContent;
    private Date replyCreateDate;
    private Date replyUpdateDate;

    private String memberNick; // 댓글 작성자 닉네임

    private Board board; // 댓글이 달린 게시글 정보 (필요 시 유지)
}
