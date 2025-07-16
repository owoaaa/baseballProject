package kr.swj.baseball.chat.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.swj.baseball.chat.model.dto.ChatRoomPreview;
import kr.swj.baseball.chat.model.service.ChatService;
import kr.swj.baseball.member.model.dto.Member;

@Controller
@RequestMapping("/chat")
public class ChatController {

    @Autowired
    private ChatService chatService;

    @GetMapping("/list")
    public String chatRoomList(Model model, HttpSession session) {
        Member loginMember = (Member) session.getAttribute("loginMember");
        int memberNo = (loginMember != null) ? loginMember.getMemberNo() : 0;

        List<ChatRoomPreview> chatRoomList = chatService.getAllChatRoomsWithJoinStatus(memberNo);
        model.addAttribute("chatRoomList", chatRoomList);

        return "chat/chatList";
    }
    
    @GetMapping("/room/{roomNo}")
    public String enterRoom(@PathVariable int roomNo, Model model, HttpSession session) {
        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/?showLoginModal=true";
        }

        // 채팅방 기본 정보 조회 (이건 아직 구현 안 되어 있다면 null 처리 또는 별도 로직)
        ChatRoomPreview room = chatService.getRoomPreviewByRoomNo(roomNo);

        // 최근 7일 메시지 조회
        model.addAttribute("room", room);
        model.addAttribute("messageList", chatService.getRecentMessages(roomNo));

        return "chat/chatRoom"; // JSP 파일명: /WEB-INF/views/chat/chatRoom.jsp
    }
    
    
}