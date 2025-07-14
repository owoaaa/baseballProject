package kr.swj.baseball.board.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.swj.baseball.board.model.dao.BoardDAO;
import kr.swj.baseball.board.model.dto.Board;
import kr.swj.baseball.board.model.dto.PageInfo;
import kr.swj.baseball.board.model.dto.Reply;

@Service
public class BoardServiceImpl implements BoardService{
	
	@Autowired
    private BoardDAO dao;

    @Override
    public List<Board> selectFreeBoardList() {
        return dao.selectFreeBoardList();
    }
    
    @Override
    public int getBoardCount(String boardType) {
        return dao.getBoardCount(boardType); 
    }

    @Override
    public List<Board> selectBoardList(PageInfo pi, String boardType) {
        return dao.selectBoardList(pi, boardType);  
    }
    
    // 마이페이지 최근 활동 조회
    @Override
    public List<Board> selectRecentBoards(int memberNo) {
        return dao.selectRecentBoards(memberNo);
    }

    @Override
    public List<Reply> selectRecentReplies(int memberNo) {
        return dao.selectRecentReplies(memberNo);
    }
    
    // 게시글
    @Override
    public int getMyPostCount(int memberNo) {
        return dao.getMyPostCount(memberNo);
    }

    @Override
    public List<Board> getMyPostList(int memberNo, PageInfo pi) {
        return dao.getMyPostList(memberNo, pi);
    }

    // 댓글
    @Override
    public int getMyReplyCount(int memberNo) {
        return dao.getMyReplyCount(memberNo);
    }

    @Override
    public List<Reply> getMyReplyList(int memberNo, PageInfo pi) {
        return dao.getMyReplyList(memberNo, pi);
    }

}
