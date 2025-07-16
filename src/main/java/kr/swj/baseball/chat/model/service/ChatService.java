package kr.swj.baseball.chat.model.service;

import java.util.List;

import kr.swj.baseball.chat.model.dto.ChatMessage;
import kr.swj.baseball.chat.model.dto.ChatRoomPreview;


public interface ChatService {
	
	List<ChatRoomPreview> getMyChatRooms(int memberNo);
	
	List<ChatRoomPreview> getAllChatRoomsWithJoinStatus(int memberNo);
	
	
	
	boolean joinChatRoom(int roomNo, int memberNo, String memberNick);
	
	boolean leaveChatRoom(int roomNo, int memberNo, String memberNick);

	
	void saveChatMessage(ChatMessage message);
	
	ChatRoomPreview getRoomPreviewByRoomNo(int roomNo);
	List<ChatMessage> getRecentMessages(int roomNo);
}
