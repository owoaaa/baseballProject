package kr.swj.baseball.board.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.swj.baseball.board.model.dto.Board;
import kr.swj.baseball.board.model.dto.PageInfo;

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

}
