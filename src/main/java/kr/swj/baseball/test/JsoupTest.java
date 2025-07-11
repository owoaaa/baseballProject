package kr.swj.baseball.test;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class JsoupTest {
	public static void main(String[] args) throws Exception {
		Document doc = Jsoup.connect("https://www.cbssports.com/mlb/standings/")
				.userAgent("Mozilla/5.0")
				.get();

		Elements rows = doc.select("table.data-table tbody tr");
		System.out.println("✅ CBS 테이블 row 수: " + rows.size());
		System.out.println("🔍 페이지 일부:\n" + doc.html().substring(0, 1000));

		for (Element row : rows) {
			Elements cols = row.select("td");
			if (cols.size() > 4) {
				String team = cols.get(0).text();
				String wins = cols.get(1).text();
				String losses = cols.get(2).text();
				System.out.println(team + " - " + wins + "승 " + losses + "패");
			}
		}
	}
}
