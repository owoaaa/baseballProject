package kr.swj.baseball.board.model.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Service;

@Service
public class KboStatService {

    public List<Map<String, Object>> getHitterStats() throws IOException {
        List<Map<String, Object>> list = new ArrayList<>();
        String url = "https://www.koreabaseball.com/Record/Player/HitterBasic/Basic1.aspx";

        Document doc = Jsoup.connect(url).userAgent("Mozilla/5.0").get();
        Elements rows = doc.select("table.tData tbody tr");

        for (Element row : rows) {
            Elements cols = row.select("td");
            if (cols.size() >= 17) {
                Map<String, Object> map = new HashMap<>();
                map.put("name", cols.get(1).text());       // 선수명
                map.put("avg", cols.get(4).text());         // AVG
                map.put("pa", cols.get(2).text());          // PA
                map.put("ab", cols.get(3).text());          // AB
                map.put("r", cols.get(6).text());           // R
                map.put("hits", cols.get(7).text());        // H
                map.put("hr", cols.get(11).text());         // HR
                map.put("rbi", cols.get(13).text());        // RBI
                map.put("obp", cols.get(14).text());        // 출루율
                map.put("slg", cols.get(15).text());        // 장타율
                map.put("ops", cols.get(16).text());        // OPS
                list.add(map);
            }
            System.out.println("타자 row 수: " + rows.size());
        }
        return list;
    }

    public List<Map<String, Object>> getPitcherStats() throws IOException {
        List<Map<String, Object>> list = new ArrayList<>();
        String url = "https://www.koreabaseball.com/Record/Player/PitcherBasic/Basic1.aspx";

        Document doc = Jsoup.connect(url).userAgent("Mozilla/5.0").get();
        Elements rows = doc.select("table.tData tbody tr");

        for (Element row : rows) {
            Elements cols = row.select("td");
            if (cols.size() >= 21) {
                Map<String, Object> map = new HashMap<>();
                map.put("name", cols.get(1).text());        // 선수명
                map.put("era", cols.get(2).text());         // ERA
                map.put("games", cols.get(3).text());       // 경기수 (G)
                map.put("wins", cols.get(4).text());        // 승 (W)
                map.put("losses", cols.get(5).text());      // 패 (L)
                map.put("saves", cols.get(6).text());       // 세이브 (SV)
                map.put("innings", cols.get(10).text());    // 이닝 (IP)
                map.put("strikeouts", cols.get(15).text()); // 삼진 (SO)
                map.put("walks", cols.get(13).text());      // 볼넷 (BB)
                map.put("hitsAllowed", cols.get(11).text());// 피안타 (H)
                map.put("whip", cols.get(20).text());       // WHIP
                list.add(map);
            }
            System.out.println("투수 row 수: " + rows.size());
        }
        return list;
    }
    
    
} 