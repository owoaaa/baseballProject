package kr.swj.baseball.board.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.swj.baseball.board.model.dao.BoardDAO;
import kr.swj.baseball.board.model.dto.Board;

@Service
public class BoardServiceImpl implements BoardService{
	
	@Autowired
    private BoardDAO boardDAO;

    @Override
    public List<Board> selectFreeBoardList() {
        return boardDAO.selectFreeBoardList();
    }

}
