package kr.swj.baseball.main.controller;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.swj.baseball.main.dto.TeamRank;
import kr.swj.baseball.board.model.service.KboRankingService;
import kr.swj.baseball.board.model.service.MlbRankingService;
import kr.swj.baseball.main.dto.MlbTeamRank;

@Controller
public class MainController {

    @RequestMapping("/")
    public String main(Model model) {
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