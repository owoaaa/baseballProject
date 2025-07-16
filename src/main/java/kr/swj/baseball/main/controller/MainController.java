package kr.swj.baseball.main.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.swj.baseball.main.dto.TeamRank;
import kr.swj.baseball.member.model.dto.Member;
import kr.swj.baseball.board.model.service.KboRankingService;
import kr.swj.baseball.board.model.service.MlbRankingService;
import kr.swj.baseball.chat.model.dto.ChatRoomPreview;
import kr.swj.baseball.chat.model.service.ChatService;
import kr.swj.baseball.main.dto.MlbTeamRank;

@Controller
public class MainController {
	
	@Autowired
    private ChatService chatService;

    @RequestMapping("/")
    public String main(Model model, HttpSession session) {
    	
    	 Member loginMember = (Member) session.getAttribute("loginMember");

         if (loginMember != null) {
             List<ChatRoomPreview> myChatRooms = chatService.getMyChatRooms(loginMember.getMemberNo());
             model.addAttribute("myChatRooms", myChatRooms);
         }
    	
    	
    	
    	
    	
        try {
            // KBO 순위
            KboRankingService kboService = new KboRankingService();
            List<TeamRank> kboList = kboService.getRanking();
            model.addAttribute("kboList", kboList);

            // MLB 순위
            MlbRankingService mlbService = new MlbRankingService();
            Map<String, List<MlbTeamRank>> mlbGroupedList = mlbService.getGroupedMlbRanking();
            model.addAttribute("mlbGroupedList", mlbGroupedList);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return "main";
    }
}