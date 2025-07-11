<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>Baseball Community</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-white text-gray-800">

  <!-- 공통 헤더 -->
  <header class="w-full shadow-sm bg-white sticky top-0 z-50">
    <div class="max-w-7xl mx-auto px-4 py-4 flex justify-between items-center">
      <h1 class="text-2xl font-bold text-blue-600">⚾ Baseball Community</h1>
      <nav class="flex items-center space-x-6 text-gray-700">
        <a href="/" title="홈" class="hover:text-blue-500">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
            <path stroke-linecap="round" stroke-linejoin="round" d="M3 9.75L12 3l9 6.75V21a1.5 1.5 0 01-1.5 1.5H4.5A1.5 1.5 0 013 21V9.75z" />
          </svg>
        </a>
        <a href="#" title="로그인" class="hover:text-blue-500" onclick="event.preventDefault(); openModal();">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
            <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 9V5.25a2.25 2.25 0 00-2.25-2.25H5.25A2.25 2.25 0 003 5.25v13.5A2.25 2.25 0 005.25 21h8.25a2.25 2.25 0 002.25-2.25V15" />
            <path stroke-linecap="round" stroke-linejoin="round" d="M18 12H9m0 0l3-3m-3 3l3 3" />
          </svg>
        </a>
        <a href="/member/signUp" title="회원가입" class="hover:text-blue-500">
          <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" class="size-6">
            <path stroke-linecap="round" stroke-linejoin="round" d="M18 7.5v3m0 0v3m0-3h3m-3 0h-3m-2.25-4.125a3.375 3.375 0 1 1-6.75 0 3.375 3.375 0 0 1 6.75 0ZM3 19.235v-.11a6.375 6.375 0 0 1 12.75 0v.109A12.318 12.318 0 0 1 9.374 21c-2.331 0-4.512-.645-6.374-1.766Z" />
          </svg>
        </a>
      </nav>
    </div>
  </header>

  <!-- 본문 영역 -->
  <main class="max-w-7xl mx-auto px-4 py-10 grid grid-cols-1 md:grid-cols-4 gap-8">
    
    <!-- 왼쪽 사이드바 -->
    <aside class="md:col-span-1 space-y-4">
      <h2 class="text-lg font-bold text-gray-700">📋 게시판</h2>
      <ul class="space-y-2 text-sm text-gray-700">
        <li><a href="/board/freeboard" class="block hover:text-blue-500">자유게시판</a></li>
        <li><a href="#" class="block hover:text-blue-500">KBO 게시판</a></li>
        <li><a href="#" class="block hover:text-blue-500">MLB 게시판</a></li>
        <li><a href="#" class="block hover:text-blue-500">구단별 게시판</a></li>
        <li>
          <details class="px-4 py-2">
            <summary class="cursor-pointer hover:text-blue-500">기록</summary>
            <ul class="ml-4 space-y-1">
              <li><a href="/board/mlbRecord" class="block hover:underline">MLB 선수</a></li>
              <li><a href="/board/mlbStanding" class="block hover:underline">MLB 순위</a></li>
              <li><a href="/board/kboRecord" class="block hover:underline">KBO 선수</a></li>
              <li><a href="/board/kboStanding" class="block hover:underline">KBO 순위</a></li>
            </ul>
          </details>
        </li>
      </ul>
    </aside>

    <!-- 오른쪽 콘텐츠 영역 -->
    <section class="md:col-span-3 space-y-8">
      <jsp:include page="${contentPage}" />
    </section>
  </main>

  <footer class="mt-20 py-6 bg-gray-100 text-center text-sm text-gray-500">
    &copy; 2025 Baseball Community. All rights reserved.
  </footer>

  <!-- 로그인 모달 스크립트 -->
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