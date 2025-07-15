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
    
    // 게시글 상세
    Board selectBoardDetail(int boardNo);
    // 조회수 증가
    void increaseViewCount(int boardNo);
    // 댓글 목록 조회
    List<Reply> selectReplyList(int boardNo);
    
    // 좋아요 ajax
    boolean toggleLike(int boardNo, int memberNo);
    int getLikeCount(int boardNo);
    
    // 댓글작성
    void insertReply(Reply reply);
    
    // 게시글 작성
    int insertBoard(Board board);
    
    // 게시글 수정
    int updateBoard(Board board);

}
