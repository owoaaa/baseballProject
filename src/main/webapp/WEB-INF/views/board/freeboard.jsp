<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>자유게시판 - Baseball Community</title>
  <link rel="stylesheet" href="/resources/css/style.css">
  <script src="https://cdn.tailwindcss.com"></script>

  <!-- Grid.js CDN 추가 -->
  <link href="https://unpkg.com/gridjs/dist/theme/mermaid.min.css" rel="stylesheet" />
  <script src="https://unpkg.com/gridjs/dist/gridjs.umd.js"></script>
</head>
<body class="bg-white text-gray-800">

  <!-- 상단 네비게이션 -->
  <jsp:include page="/WEB-INF/views/common/header.jsp" />

  <!-- 본문 -->
  <main class="max-w-7xl mx-auto px-4 py-12 grid grid-cols-1 md:grid-cols-4 gap-8">

    <!-- 왼쪽 사이드 게시판 메뉴 -->
    <jsp:include page="/WEB-INF/views/common/sidebar.jsp" />

    <!-- Grid.js 테이블 영역 -->
    <section class="md:col-span-3">
      <div class="flex justify-between items-center mb-6">
        <h2 class="text-2xl font-bold text-gray-800">자유게시판</h2>
        <a href="#" class="bg-blue-600 text-white px-4 py-2 rounded-md hover:bg-blue-700">글쓰기</a>
      </div>

      <!-- Grid.js를 렌더링할 DIV -->
      <div id="boardTable"></div>
    </section>
  </main>
  <jsp:include page="/WEB-INF/views/common/footer.jsp" />
  <script src="/resources/js/darkMode.js"></script>
  <!-- Grid.js 테이블 생성 스크립트 -->
  <script>
    new gridjs.Grid({
        columns: [
            { name: "번호", width: "5%" },
            { name: "제목", width: "40%" },
            { name: "작성자", width: "13%" },
            { name: "작성일", width: "15%" },
            { name: "조회수", width: "13%", sort:true },
            { name: "좋아요", width: "13%", sort:true}
        ],
        data: [
            [1, "첫 번째 글입니다", "홍길동", "2025-06-25", 123, 7],
            [2, "두 번째 글입니다", "김철수", "2025-06-26", 58, 4],
            [3, "세 번째 글입니다", "이영희", "2025-06-27", 99, 6],
        ],
        pagination: { limit: 5 },
        sort: false, // 정렬
        search: true, // 검색
    }).render(document.getElementById("boardTable"));
  </script>

</body>
</html>