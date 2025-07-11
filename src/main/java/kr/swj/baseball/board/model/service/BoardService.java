package kr.swj.baseball.board.model.service;

import java.util.List;

import kr.swj.baseball.board.model.dto.Board;
import kr.swj.baseball.board.model.dto.PageInfo;

public interface BoardService {
	List<Board> selectFreeBoardList();
	
	  int getBoardCount(String boardType); // 총 게시글 수
	  List<Board> selectBoardList(PageInfo pi, String boardType); // 목록

}
