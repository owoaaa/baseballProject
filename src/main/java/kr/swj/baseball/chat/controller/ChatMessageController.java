package kr.swj.baseball.chat.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

import kr.swj.baseball.chat.model.dto.ChatMessage;
import kr.swj.baseball.chat.model.service.ChatService;

@Controller
public class ChatMessageController {

    @Autowired
    private ChatService chatService;

    @Autowired
    private SimpMessagingTemplate messagingTemplate;

    @MessageMapping("/chat/message") // 클라이언트는 /pub/chat/message로 전송
    public void handleMessage(ChatMessage message) {
        // DB 저장
        chatService.saveChatMessage(message);

        // 구독자에게 메시지 전송
        messagingTemplate.convertAndSend(
            "/sub/chat/room/" + message.getRoomNo(),
            message
        );
    }
}