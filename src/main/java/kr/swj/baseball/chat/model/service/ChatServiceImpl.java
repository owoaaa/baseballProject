package kr.swj.baseball.chat.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.swj.baseball.chat.model.dao.ChatDAO;
import kr.swj.baseball.chat.model.dto.ChatMessage;
import kr.swj.baseball.chat.model.dto.ChatRoomPreview;


@Service
public class ChatServiceImpl implements ChatService{

	@Autowired
    private ChatDAO dao;

    @Override
    public List<ChatRoomPreview> getMyChatRooms(int memberNo) {
        return dao.selectMyChatRooms(memberNo);
    }
    
    @Override
    public List<ChatRoomPreview> getAllChatRoomsWithJoinStatus(int memberNo) {
        return dao.selectAllChatRooms(memberNo);
    }
    
    
    @Override
    public boolean joinChatRoom(int roomNo, int memberNo, String memberNick) {
        int result = dao.insertChatMember(roomNo, memberNo);

        if (result > 0) {
            dao.insertSystemMessage(roomNo, memberNo, memberNick + "님이 입장하셨습니다.");
            return true;
        }
        return false;
    }
    
    @Override
    public boolean leaveChatRoom(int roomNo, int memberNo, String memberNick) {
        int result = dao.deleteChatMember(roomNo, memberNo);

        if (result > 0) {
            dao.insertSystemMessage(roomNo, memberNo, memberNick + "님이 퇴장하셨습니다.");
            return true;
        }
        return false;
    }
    
    
    
    @Override
    public void saveChatMessage(ChatMessage message) {
        dao.insertChatMessage(message);
    }
    
    @Override
    public ChatRoomPreview getRoomPreviewByRoomNo(int roomNo) {
        return dao.selectRoomPreviewByRoomNo(roomNo);
    }

    @Override
    public List<ChatMessage> getRecentMessages(int roomNo) {
        return dao.selectRecentMessages(roomNo);
    }
    
    
}
