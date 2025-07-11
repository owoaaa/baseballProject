package kr.swj.baseball.board.model.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Service;

import kr.swj.baseball.main.dto.TeamRank;

@Service
public class KboRankingService {

    public List<TeamRank> getRanking() throws IOException {
        List<TeamRank> list = new ArrayList<>();

        Document doc = Jsoup.connect("https://www.koreabaseball.com/Record/TeamRank/TeamRankDaily.aspx")
                .userAgent("Mozilla/5.0")
                .referrer("https://www.google.com")
                .get();

        Elements rows = doc.select("table.tData tbody tr");

        for (Element row : rows) {
            Elements cols = row.select("td");

            if (cols.size() >= 12) {
                try {
                    int rank = Integer.parseInt(cols.get(0).text());
                    String teamName = cols.get(1).text();
                    int games = Integer.parseInt(cols.get(2).text());
                    int wins = Integer.parseInt(cols.get(3).text());
                    int losses = Integer.parseInt(cols.get(4).text());
                    int draws = Integer.parseInt(cols.get(5).text());
                    String winRate = cols.get(6).text();
                    String gap = cols.get(7).text();
                    String last10 = cols.get(8).text();
                    String streak = cols.get(9).text();
                    String home = cols.get(10).text();
                    String away = cols.get(11).text();

                    TeamRank team = new TeamRank();
                    team.setRank(rank);
                    team.setTeamName(teamName);
                    team.setGames(games);
                    team.setWins(wins);
                    team.setLosses(losses);
                    team.setDraws(draws);
                    team.setWinRate(winRate);
                    team.setGap(gap);
                    team.setLast10(last10);
                    team.setStreak(streak);
                    team.setHome(home);
                    team.setAway(away);

                    list.add(team);
                } catch (NumberFormatException e) {
                    // 숫자로 파싱 안 되는 행은 무시
                    continue;
                }
            }
        }

        return list;
    }
}