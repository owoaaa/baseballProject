package kr.swj.baseball.board.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.swj.baseball.board.model.dto.Board;
import kr.swj.baseball.board.model.dto.PageInfo;
import kr.swj.baseball.board.model.dto.Reply;

@Repository
public class BoardDAO {
	@Autowired
    private SqlSessionTemplate sqlSession;

    public List<Board> selectFreeBoardList() {
        return sqlSession.selectList("boardMapper.selectFreeBoardList");
    }
    
    public int getBoardCount(String boardType) {
        return sqlSession.selectOne("boardMapper.getBoardCount", boardType);
    }

    public List<Board> selectBoardList(PageInfo pi, String boardType) {
        Map<String, Object> param = new HashMap<>();
        param.put("startRow", pi.getStartRow());
        param.put("endRow", pi.getEndRow());
        param.put("boardType", boardType);
        return sqlSession.selectList("boardMapper.selectBoardList", param);
    }
    
    // 마이페이지 최근 활동 조회
    public List<Board> selectRecentBoards(int memberNo) {
        return sqlSession.selectList("boardMapper.selectRecentBoards", memberNo);
    }

    public List<Reply> selectRecentReplies(int memberNo) {
        return sqlSession.selectList("boardMapper.selectRecentReplies", memberNo);
    }
    
    
    // 게시글
    public int getMyPostCount(int memberNo) {
        return sqlSession.selectOne("boardMapper.getMyPostCount", memberNo);
    }

    public List<Board> getMyPostList(int memberNo, PageInfo pi) {
        Map<String, Object> map = new HashMap<>();
        map.put("memberNo", memberNo);
        map.put("startRow", pi.getStartRow());
        map.put("endRow", pi.getEndRow());
        return sqlSession.selectList("boardMapper.getMyPostList", map);
    }

    // 댓글
    public int getMyReplyCount(int memberNo) {
        return sqlSession.selectOne("boardMapper.getMyReplyCount", memberNo);
    }

    public List<Reply> getMyReplyList(int memberNo, PageInfo pi) {
        Map<String, Object> map = new HashMap<>();
        map.put("memberNo", memberNo);
        map.put("startRow", pi.getStartRow());
        map.put("endRow", pi.getEndRow());
        return sqlSession.selectList("boardMapper.getMyReplyList", map);
    }
 	
    // 게시글 상세 조회
    public Board selectBoardDetail(int boardNo) {
        return sqlSession.selectOne("boardMapper.selectBoardDetail", boardNo);
    }
    // 조회수 증가
    public void increaseViewCount(int boardNo) {
        sqlSession.update("boardMapper.increaseViewCount", boardNo);
    }
    // 댓글 목록 조회
    public List<Reply> selectReplyList(int boardNo) {
        return sqlSession.selectList("boardMapper.selectReplyList", boardNo);
    }
    
    // 좋아요 ajax
    public boolean checkLike(int boardNo, int memberNo) {
        Map<String, Object> map = new HashMap<>();
        map.put("boardNo", boardNo);
        map.put("memberNo", memberNo);
        map.put("likeType", "LIKE");

        Integer result = sqlSession.selectOne("boardMapper.checkLike", map);
        return result != null && result > 0;
    }

    public void insertLike(int boardNo, int memberNo) {
        Map<String, Object> map = new HashMap<>();
        map.put("boardNo", boardNo);
        map.put("memberNo", memberNo);
        map.put("likeType", "LIKE");

        sqlSession.insert("boardMapper.insertLike", map);
    }

    public void deleteLike(int boardNo, int memberNo) {
        Map<String, Object> map = new HashMap<>();
        map.put("boardNo", boardNo);
        map.put("memberNo", memberNo);
        map.put("likeType", "LIKE");

        sqlSession.delete("boardMapper.deleteLike", map);
    }

    public int getLikeCount(int boardNo) {
        return sqlSession.selectOne("boardMapper.getLikeCount", boardNo);
    }
    
    // 댓글 작성
    public void insertReply(Reply reply) {
        sqlSession.insert("boardMapper.insertReply", reply);
    }
    
    // 게시글 작성
    public int insertBoard(Board board) {
        return sqlSession.insert("boardMapper.insertBoard", board);
    }

    public int selectInsertedBoardNo() {
        return sqlSession.selectOne("boardMapper.selectInsertedBoardNo");
    }
    
    // 게시글 수정
    public int updateBoard(Board board) {
        return sqlSession.update("boardMapper.updateBoard", board);
    }
    
    
    // 최근 검색어 5개 조회
    public List<String> selectRecentSearches(int memberNo) {
        return sqlSession.selectList("boardMapper.selectRecentSearches", memberNo);
    }
    
    // 검색 기록 저장
    public int insertSearchHistory(int memberNo, String term) {
        Map<String, Object> param = new HashMap<>();
        param.put("memberNo", memberNo);
        param.put("term", term);
        return sqlSession.insert("boardMapper.insertSearchHistory", param);
    }

    // 키워드 기반 게시글 검색
    public List<Board> searchBoardList(Map<String, Object> param) {
        return sqlSession.selectList("boardMapper.searchBoardList", param);
    }

    // 검색 게시글 수 조회
    public int getSearchCount(Map<String, String> param) {
        return sqlSession.selectOne("boardMapper.getSearchCount", param);
    }

}
