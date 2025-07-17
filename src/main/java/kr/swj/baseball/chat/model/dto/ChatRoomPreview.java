package kr.swj.baseball.chat.model.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ChatRoomPreview {
    private int roomNo;
    private String roomName;
    private String teamLogoUrl;
    private String lastMessage;
    private int participantCount;
    
    private boolean joined; // 로그인한 회원이 참여중인지 여부 확인용

}
