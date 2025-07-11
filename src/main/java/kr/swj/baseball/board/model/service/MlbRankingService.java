package kr.swj.baseball.board.model.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.*;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Service;

import kr.swj.baseball.main.dto.MlbTeamRank;

@Service
public class MlbRankingService {

    public Map<String, List<MlbTeamRank>> getGroupedMlbRanking() throws Exception {
        String apiUrl = "https://statsapi.mlb.com/api/v1/standings?leagueId=103,104&season=2025&standingsTypes=regularSeason";

        HttpURLConnection connection = (HttpURLConnection) new URL(apiUrl).openConnection();
        connection.setRequestMethod("GET");
        BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
        String inputLine;
        StringBuilder response = new StringBuilder();

        while ((inputLine = in.readLine()) != null) {
            response.append(inputLine);
        }
        in.close();

        JSONObject json = new JSONObject(response.toString());
        JSONArray records = json.getJSONArray("records");

        Map<String, List<MlbTeamRank>> groupedRanking = new LinkedHashMap<>();

        // 중복 처리 로직 제거하고 모든 레코드 처리
        for (int i = 0; i < records.length(); i++) {
            JSONObject record = records.getJSONObject(i);
            int divisionId = record.getJSONObject("division").getInt("id");
            String divisionName = getDivisionNameById(divisionId);
            
            JSONArray teamRecords = record.getJSONArray("teamRecords");

            // 이미 존재하는 디비전이면 기존 리스트를 사용하고, 없으면 새로 생성
            List<MlbTeamRank> divisionTeams = groupedRanking.getOrDefault(divisionName, new ArrayList<>());

            for (int j = 0; j < teamRecords.length(); j++) {
                JSONObject teamObj = teamRecords.getJSONObject(j);

                String teamName = teamObj.getJSONObject("team").getString("name");
                int wins = teamObj.getInt("wins");
                int losses = teamObj.getInt("losses");
                String gamesBackStr = teamObj.optString("gamesBack", "0");
                double gamesBack;
                try {
                    gamesBack = Double.parseDouble(gamesBackStr);
                } catch (NumberFormatException e) {
                    gamesBack = 0.0;
                }

                MlbTeamRank team = new MlbTeamRank();
                team.setDivisionName(divisionName);
                team.setTeamName(teamName);
                team.setWins(wins);
                team.setLosses(losses);
                team.setGamesBack(gamesBack);

                divisionTeams.add(team);
            }

            groupedRanking.put(divisionName, divisionTeams);
        }

        for (String key : groupedRanking.keySet()) {
            System.out.println("division key = " + key);
        }

        return groupedRanking;
    }

    private String getDivisionNameById(int id) {
        switch (id) {
            case 200: return "AL 서부";
            case 201: return "AL 동부";
            case 202: return "AL 중부";
            case 203: return "NL 서부";
            case 204: return "NL 동부";
            case 205: return "NL 중부";
            default: return "Unknown";
        }
    }
}