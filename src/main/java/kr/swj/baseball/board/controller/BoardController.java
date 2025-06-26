package kr.swj.baseball.board.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.swj.baseball.board.model.dto.Board;
import kr.swj.baseball.board.model.service.BoardService;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	@Autowired
    private BoardService boardService;
	
	@RequestMapping("/freeboard")
	public String freeboardList() {
	    return "board/freeboard";
	}
	

	// db 연동
	/*
	 * @RequestMapping("/freeboard") public String freeboardList(Model model) {
	 * List<Board> boardList = boardService.selectFreeBoardList();
	 * model.addAttribute("boardList", boardList); return "board/freeboard"; }
	 */

}
