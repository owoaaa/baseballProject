package kr.swj.baseball.chat.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.*;

@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {

    // 클라이언트가 웹소켓 서버에 연결할 endpoint
    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {
        registry.addEndpoint("/ws-stomp") // ex: new SockJS('/ws-stomp')로 연결
                .setAllowedOriginPatterns("*") // CORS 허용
                .withSockJS();
    }

    // 메시지 중개자 (브로커) 설정
    @Override
    public void configureMessageBroker(MessageBrokerRegistry registry) {
        registry.enableSimpleBroker("/sub");           // 구독 경로: 메시지 받는 쪽
        registry.setApplicationDestinationPrefixes("/pub"); // 발행 경로: 메시지 보내는 쪽
    }
}