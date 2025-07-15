package kr.swj.baseball.board.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.swj.baseball.board.model.dto.Reply;
import kr.swj.baseball.board.model.service.BoardService;
import kr.swj.baseball.member.model.dto.Member;

@Controller
@RequestMapping("/reply")
public class ReplyController {

    @Autowired
    private BoardService boardService;

    @PostMapping("/insert")
    public String insertReply(@RequestBody Reply inputReply, HttpSession session, Model model) {
        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) return "board/replyList"; // 로그인 안했을 때도 댓글만 빈 걸로 리턴

        inputReply.setMemberNo(loginMember.getMemberNo());

        boardService.insertReply(inputReply);

        List<Reply> replyList = boardService.selectReplyList(inputReply.getBoardNo());
        model.addAttribute("replyList", replyList);

        return "board/replyList";
    }
}
