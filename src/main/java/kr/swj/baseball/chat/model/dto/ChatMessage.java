package kr.swj.baseball.chat.model.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ChatMessage {
    private int roomNo;
    private int memberNo;
    private int messageNo;
    private String nickname;
    private String message;
    private String messageType; // TEXT, SYSTEM
    private String sendDate;    // 프론트에서 필요할 경우 사용하기 위해 만들어둠

}
