package kr.swj.baseball.board.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.swj.baseball.board.model.dto.Board;

@Repository
public class BoardDAO {
	@Autowired
    private SqlSessionTemplate sqlSession;

    public List<Board> selectFreeBoardList() {
        return sqlSession.selectList("boardMapper.selectFreeBoardList");
    }

}
