<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>Baseball Community</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-white text-gray-800">

  <!-- 상단 네비게이션 -->
  <header class="w-full shadow-sm bg-white sticky top-0 z-50">
    <div class="max-w-7xl mx-auto px-4 py-4 flex justify-between items-center">
      <h1 class="text-2xl font-bold text-blue-600">⚾ Baseball Community</h1>
      
      <nav class="flex items-center space-x-6 text-gray-700">
        <!-- 홈 아이콘 -->
        <a href="#" title="홈" class="hover:text-blue-500">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none"
            viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
            <path stroke-linecap="round" stroke-linejoin="round"
              d="M3 9.75L12 3l9 6.75V21a1.5 1.5 0 01-1.5 1.5H4.5A1.5 1.5 0 013 21V9.75z" />
          </svg>
        </a>
        <!-- 로그인 아이콘 -->
        <a href="#" title="로그인" class="hover:text-blue-500" onclick="event.preventDefault(); openModal();">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none"
            viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
            <path stroke-linecap="round" stroke-linejoin="round"
              d="M15.75 9V5.25a2.25 2.25 0 00-2.25-2.25H5.25A2.25 2.25 0 003 5.25v13.5A2.25 2.25 0 005.25 21h8.25a2.25 2.25 0 002.25-2.25V15" />
            <path stroke-linecap="round" stroke-linejoin="round"
              d="M18 12H9m0 0l3-3m-3 3l3 3" />
          </svg>
        </a>
        <!-- 회원가입 아이콘 -->
        <a href="/member/signUp" title="회원가입" class="hover:text-blue-500">
          <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" class="size-6">
            <path stroke-linecap="round" stroke-linejoin="round" d="M18 7.5v3m0 0v3m0-3h3m-3 0h-3m-2.25-4.125a3.375 3.375 0 1 1-6.75 0 3.375 3.375 0 0 1 6.75 0ZM3 19.235v-.11a6.375 6.375 0 0 1 12.75 0v.109A12.318 12.318 0 0 1 9.374 21c-2.331 0-4.512-.645-6.374-1.766Z" />
          </svg>
        </a>
      </nav>
    </div>
  </header>

  <!-- 본문 레이아웃 -->
  <main class="max-w-7xl mx-auto px-4 py-10 grid grid-cols-1 md:grid-cols-4 gap-8">

    <!-- 왼쪽 사이드 게시판 메뉴 -->
    <aside class="md:col-span-1 space-y-4">
      <h2 class="text-lg font-bold text-gray-700">📋 게시판</h2>
      <ul class="space-y-2 text-sm text-gray-700">
        <li><a href="/board/freeboard" class="block hover:text-blue-500">자유게시판</a></li>
        <li><a href="#" class="block hover:text-blue-500">KBO 게시판</a></li>
        <li><a href="#" class="block hover:text-blue-500">MLB 게시판</a></li>
        <li><a href="#" class="block hover:text-blue-500">구단별 게시판</a></li>
        <li><a href="#" class="block hover:text-blue-500">응원글 모음</a></li>
      </ul>
    </aside>

    <!-- 본문 콘텐츠 -->
    <section class="md:col-span-3 space-y-8">
      <div class="text-center">
        <h2 class="text-3xl font-semibold mb-4">야구를 좋아하는 사람들의 커뮤니티</h2>
        <p class="text-gray-600 mb-6">실시간 게시판, 팀 정보, 경기 토론까지!</p>
        <a href="#" class="inline-block px-6 py-3 bg-blue-600 text-white rounded-full hover:bg-blue-700 transition">
          지금 시작하기
        </a>
      </div>

      <!-- 예시 콘텐츠 카드 -->
      <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
        <div class="p-6 border rounded-xl shadow-sm hover:shadow-md">
          <h3 class="text-xl font-bold mb-2">실시간 게시판</h3>
          <p class="text-gray-600">야구에 대한 다양한 이야기를 나눠보세요.</p>
        </div>
        <div class="p-6 border rounded-xl shadow-sm hover:shadow-md">
          <h3 class="text-xl font-bold mb-2">팀별 정보</h3>
          <p class="text-gray-600">구단별 뉴스와 순위를 확인해보세요.</p>
        </div>
        <div class="p-6 border rounded-xl shadow-sm hover:shadow-md">
          <h3 class="text-xl font-bold mb-2">경기 분석</h3>
          <p class="text-gray-600">커뮤니티에서 다양한 분석을 공유해요.</p>
        </div>
      </div>
    </section>

  </main>

  <!-- 로그인 모달 -->
  <div id="loginModal" class="fixed inset-0 bg-black bg-opacity-50 backdrop-blur-sm flex items-center justify-center hidden z-50">
    <div class="bg-white p-8 rounded-lg shadow-lg w-full max-w-sm relative">
      <button class="absolute top-2 right-2 text-gray-500 hover:text-gray-800" onclick="closeModal()">✕</button>
      <h2 class="text-xl font-bold mb-4 text-center">로그인</h2>
      <form action="/member/login" method="post" class="space-y-4">
        <input type="text" name="memberId" placeholder="아이디" required class="w-full px-4 py-2 border rounded-md">
        <input type="password" name="memberPw" placeholder="비밀번호" required class="w-full px-4 py-2 border rounded-md">
        <button type="submit" class="w-full bg-blue-600 text-white py-2 rounded-md hover:bg-blue-700">로그인</button>
      </form>
      <p class="mt-4 text-sm text-center text-gray-600">
        아이디가 없으신가요?
        <a href="/member/signUp" class="text-blue-600 hover:underline">회원가입</a>
      </p>
    </div>
  </div>

  <!-- 푸터 -->
  <footer class="mt-20 py-6 bg-gray-100 text-center text-sm text-gray-500">
    &copy; 2025 Baseball Community. All rights reserved.
  </footer>

  <script>
    function openModal() {
      document.getElementById('loginModal').classList.remove('hidden');
    }
    function closeModal() {
      document.getElementById('loginModal').classList.add('hidden');
    }
  </script>

</body>
</html>
