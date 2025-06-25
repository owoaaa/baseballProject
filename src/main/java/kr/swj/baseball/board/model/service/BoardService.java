package kr.swj.baseball.board.model.service;

import java.util.List;

import kr.swj.baseball.board.model.dto.Board;

public interface BoardService {
	List<Board> selectFreeBoardList();

}
