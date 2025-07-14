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
 	

}
