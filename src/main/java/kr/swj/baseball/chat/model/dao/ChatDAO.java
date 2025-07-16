package kr.swj.baseball.chat.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.swj.baseball.chat.model.dto.ChatMessage;
import kr.swj.baseball.chat.model.dto.ChatRoomPreview;

@Repository
public class ChatDAO {

	@Autowired
    private SqlSessionTemplate sqlSession;

    public List<ChatRoomPreview> selectMyChatRooms(int memberNo) {
        return sqlSession.selectList("chatMapper.selectMyChatRooms", memberNo);
    }

    public List<ChatRoomPreview> selectAllChatRooms(int memberNo) {
        return sqlSession.selectList("chatMapper.selectAllChatRooms", memberNo);
    }
    
    
    public int insertChatMember(int roomNo, int memberNo) {
        Map<String, Object> param = new HashMap<>();
        param.put("roomNo", roomNo);
        param.put("memberNo", memberNo);
        return sqlSession.insert("chatMapper.insertChatMember", param);
    }

    public int insertSystemMessage(int roomNo, int memberNo, String content) {
        Map<String, Object> param = new HashMap<>();
        param.put("roomNo", roomNo);
        param.put("memberNo", memberNo);
        param.put("content", content);
        return sqlSession.insert("chatMapper.insertSystemMessage", param);
    }
    
    
    
    public int deleteChatMember(int roomNo, int memberNo) {
        Map<String, Object> param = new HashMap<>();
        param.put("roomNo", roomNo);
        param.put("memberNo", memberNo);
        return sqlSession.delete("chatMapper.deleteChatMember", param);
    }
    
    public int insertChatMessage(ChatMessage message) {
        return sqlSession.insert("chatMapper.insertChatMessage", message);
    }
    
    public ChatRoomPreview selectRoomPreviewByRoomNo(int roomNo) {
        return sqlSession.selectOne("chatMapper.selectRoomPreviewByRoomNo", roomNo);
    }

    public List<ChatMessage> selectRecentMessages(int roomNo) {
        return sqlSession.selectList("chatMapper.selectRecentMessages", roomNo);
    }

    
    
}
