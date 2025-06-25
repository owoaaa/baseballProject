<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>자유게시판 - Baseball Community</title>
  <script src="https://cdn.tailwindcss.com"></script>

  <!-- Grid.js CDN 추가 -->
  <link href="https://unpkg.com/gridjs/dist/theme/mermaid.min.css" rel="stylesheet" />
  <script src="https://unpkg.com/gridjs/dist/gridjs.umd.js"></script>
</head>
<body class="bg-white text-gray-800">

  <!-- 상단 네비게이션 -->
  <header class="w-full shadow-sm bg-white sticky top-0 z-50">
    <div class="max-w-7xl mx-auto px-4 py-4 flex justify-between items-center">
      <h1 class="text-2xl font-bold text-blue-600">⚾ Baseball Community</h1>
      <nav class="flex items-center space-x-6 text-gray-700">
        <a href="/" title="홈" class="hover:text-blue-500">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
            <path stroke-linecap="round" stroke-linejoin="round" d="M3 9.75L12 3l9 6.75V21a1.5 1.5 0 01-1.5 1.5H4.5A1.5 1.5 0 013 21V9.75z" />
          </svg>
        </a>
        <a href="/member/myPage" title="내정보" class="hover:text-blue-500">
          <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" class="size-6">
            <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 6a3.75 3.75 0 1 1-7.5 0 3.75 3.75 0 0 1 7.5 0ZM4.501 20.118a7.5 7.5 0 0 1 14.998 0A17.933 17.933 0 0 1 12 21.75c-2.676 0-5.216-.584-7.499-1.632Z" />
          </svg>
        </a>
        <a href="/member/logout" title="로그아웃" class="hover:text-blue-500">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none"
            viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
            <path stroke-linecap="round" stroke-linejoin="round"
              d="M15.75 9V5.25A2.25 2.25 0 0013.5 3H5.25A2.25 2.25 0 003 5.25v13.5A2.25 2.25 0 005.25 21H13.5a2.25 2.25 0 002.25-2.25V15" />
            <path stroke-linecap="round" stroke-linejoin="round"
              d="M18 12H9m0 0l3-3m-3 3l3 3" />
          </svg>
        </a>
      </nav>
    </div>
  </header>

  <!-- 본문 -->
  <main class="max-w-7xl mx-auto px-4 py-12 grid grid-cols-1 md:grid-cols-4 gap-8">

    <!-- 왼쪽 사이드 게시판 메뉴 -->
    <aside class="md:col-span-1 space-y-4">
      <h2 class="text-lg font-bold text-gray-700">📋 게시판</h2>
      <ul class="space-y-2 text-sm text-gray-700">
        <li><a href="#" class="block hover:text-blue-500">자유게시판</a></li>
        <li><a href="#" class="block hover:text-blue-500">KBO 게시판</a></li>
        <li><a href="#" class="block hover:text-blue-500">MLB 게시판</a></li>
        <li><a href="#" class="block hover:text-blue-500">구단별 게시판</a></li>
        <li><a href="#" class="block hover:text-blue-500">응원글 모음</a></li>
      </ul>
    </aside>

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