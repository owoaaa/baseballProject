package kr.swj.baseball.board.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
    // 내가 쓴 댓글
    @Override
    public List<Reply> getMyReplyList(int memberNo, PageInfo pi) {
        return dao.getMyReplyList(memberNo, pi);
    }
    
    
    // 게시글 상세 조회
    @Override
    public Board selectBoardDetail(int boardNo) {
        return dao.selectBoardDetail(boardNo);
    }
    // 조회수
    @Override
    public void increaseViewCount(int boardNo) {
        dao.increaseViewCount(boardNo);
    }
    // 댓글 목록 조회
    @Override
    public List<Reply> selectReplyList(int boardNo) {
        return dao.selectReplyList(boardNo);
    }
    
    // 좋아요 ajax
    @Override
    public boolean toggleLike(int boardNo, int memberNo) {
        boolean alreadyLiked = dao.checkLike(boardNo, memberNo);
        if (alreadyLiked) {
            dao.deleteLike(boardNo, memberNo);
            return false;
        } else {
            dao.insertLike(boardNo, memberNo);
            return true;
        }
    }

    @Override
    public int getLikeCount(int boardNo) {
        return dao.getLikeCount(boardNo);
    }

    // 댓글 작성
    @Override
    public void insertReply(Reply reply) {
        dao.insertReply(reply);
    }
    
    // 게시글 작성
    @Override
    public int insertBoard(Board board) {
        int result = dao.insertBoard(board);

        // insert 성공 시 시퀀스 번호 셋팅
        if (result > 0) {
            int boardNo = dao.selectInsertedBoardNo();
            board.setBoardNo(boardNo);
        }

        return result;
    }
    
    // 게시글 수정
    @Override
    public int updateBoard(Board board) {
        return dao.updateBoard(board);
    }
    
    
    @Override
    public List<String> getRecentSearches(int memberNo) {
        return dao.selectRecentSearches(memberNo);
    }

    @Override
    public int saveSearchHistory(int memberNo, String keyword) {
        return dao.insertSearchHistory(memberNo, keyword);
    }

    @Override
    public List<Board> searchBoardList(PageInfo pi, String boardType, String keyword) {
        Map<String, Object> param = new HashMap<>();
        param.put("startRow", pi.getStartRow());
        param.put("endRow", pi.getEndRow());
        param.put("boardType", boardType);
        param.put("keyword", keyword);
        return dao.searchBoardList(param);
    }

    @Override
    public int getSearchCount(String boardType, String keyword) {
        Map<String, String> param = new HashMap<>();
        param.put("boardType", boardType);
        param.put("keyword", keyword);
        return dao.getSearchCount(param);
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
