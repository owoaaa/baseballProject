package kr.swj.baseball.chat.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

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

    @MessageMapping("/chat/message")
    public void handleMessage(ChatMessage message) {
        
        // 날짜 포맷팅해서 문자열로 세팅
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String now = LocalDateTime.now().format(formatter);
        message.setSendDate(now);

        chatService.saveChatMessage(message);

        messagingTemplate.convertAndSend(
            "/sub/chat/room/" + message.getRoomNo(),
            message
        );
    }
}