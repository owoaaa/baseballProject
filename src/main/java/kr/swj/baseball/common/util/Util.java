package kr.swj.baseball.common.util;

import java.text.SimpleDateFormat;

public class Util {

	// Cross Site Scropting(XSS) 방지 처리
	// - 권한이 없는 사용자가 사이트에 스크립트를 작성하는것
	// - 웹 애플리케이션에서 발생하는 취약점
	public static String XSSHandling(String content) {
		// 스크립트나 마크업 언어에서 기호나 기능을 나타내는 문자를 변경 처리
		//   &  - &amp;
		//   <  - &lt;
		//   >  - &gt;
		//   "  - &quot;

		content = content.replaceAll("&", "&amp;"); // 순서 중요 !
		content = content.replaceAll("<", "&lt;");
		content = content.replaceAll(">", "&gt;");
		content = content.replaceAll("\"", "&quot;");

		return content;
	}
	
	// 파일명 변경 메소드
	public static String fileRename(String originFileName) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String date = sdf.format(new java.util.Date(System.currentTimeMillis()));

		int ranNum = (int) (Math.random() * 100000); // 5자리 랜덤 숫자 생성

		String str = "_" + String.format("%05d", ranNum);

		String ext = originFileName.substring(originFileName.lastIndexOf("."));

		return date + str + ext;
	}
	
	
	// 욕설 필터링 메소드
	public static String swearWordHandling(String content) {
		
		content = content.replaceAll("ㅅㅂ|시발|씨발|ㅆㅂ|ㅆ2ㅂ", "어머");
		content = content.replaceAll("느금|느검|너검|느검마|너검마|느금마|ㄴㄱㅁ", "우리 엄마");
		content = content.replaceAll("ㅄ|ㅂㅅ|병신|븅신|빙신|ㅂ1ㅅ", "나쁜");
		content = content.replaceAll("ㅅㄲ|새끼", "아이");
		content = content.replaceAll("ㅈ|좆", "풋고추");
		content = content.replaceAll("ㄲㅈ|꺼져|꺼저|끄저|끄져|껒여", "가세요");
		content = content.replaceAll("련", "아낙네");
		content = content.replaceAll("똘추", "맹구");
		
		return content;
	}

}
