package kr.swj.baseball.chat.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import kr.swj.baseball.chat.model.service.ChatService;
import kr.swj.baseball.member.model.dto.Member;

@RestController
@RequestMapping("/chat")
public class ChatRestController {

    @Autowired
    private ChatService chatService;

    @PostMapping("/join")
    public ResponseEntity<?> joinRoom(@RequestParam("roomNo") int roomNo, HttpSession session) {
        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) {
            return ResponseEntity.status(401).body("로그인이 필요합니다.");
        }

        boolean success = chatService.joinChatRoom(roomNo, loginMember.getMemberNo(), loginMember.getMemberNick());

        if (success) {
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.status(409).body("이미 참여 중이거나 오류 발생");
        }
    }
    
    @PostMapping("/leave")
    public ResponseEntity<?> leaveRoom(@RequestParam("roomNo") int roomNo, HttpSession session) {
        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) {
            return ResponseEntity.status(401).body("로그인이 필요합니다.");
        }

        boolean success = chatService.leaveChatRoom(roomNo, loginMember.getMemberNo(), loginMember.getMemberNick());

        if (success) {
            session.setAttribute("message", "채팅방에서 나갔습니다.");
            session.setAttribute("messageType", "success");
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.status(500).body("나가기 실패");
        }
    }
    
    
    
    
    
    
    
    
    
    
}