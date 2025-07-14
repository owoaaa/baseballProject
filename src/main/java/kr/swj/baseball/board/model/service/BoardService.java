package kr.swj.baseball.board.model.service;

import java.util.List;

import kr.swj.baseball.board.model.dto.Board;
import kr.swj.baseball.board.model.dto.PageInfo;
import kr.swj.baseball.board.model.dto.Reply;

public interface BoardService {
	List<Board> selectFreeBoardList();
	
  int getBoardCount(String boardType); // 총 게시글 수
  List<Board> selectBoardList(PageInfo pi, String boardType); // 목록
  
  // 마이페이지 최근 활동 조회
  List<Board> selectRecentBoards(int memberNo);
  List<Reply> selectRecentReplies(int memberNo);
	  
	  
  	// 게시글
    int getMyPostCount(int memberNo);

    List<Board> getMyPostList(int memberNo, PageInfo pi);

    // 댓글
    int getMyReplyCount(int memberNo);

    List<Reply> getMyReplyList(int memberNo, PageInfo pi);

}
