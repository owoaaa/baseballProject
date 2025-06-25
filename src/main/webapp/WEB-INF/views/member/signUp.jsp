<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>회원가입 - Baseball Community</title>
  <script src="https://cdn.tailwindcss.com"></script>
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
      </nav>
    </div>
  </header>

  <!-- 회원가입 폼 -->
  <main class="max-w-xl mx-auto px-4 py-12">
    <h2 class="text-2xl font-bold mb-6 text-center">회원가입</h2>
    <form action="/member/signUp" method="post" class="space-y-4">
        <label class="block mb-1 text-gray-700 font-medium">아이디</label>
            <input type="text" name="memberId" placeholder="아이디" required class="w-full px-4 py-2 border rounded-md">
        <label class="block mb-1 text-gray-700 font-medium">비밀번호</label>
            <input type="password" name="memberPw" placeholder="비밀번호" required class="w-full px-4 py-2 border rounded-md">
        <label class="block mb-1 text-gray-700 font-medium">닉네임</label>
            <input type="text" name="memberNick" placeholder="닉네임" required class="w-full px-4 py-2 border rounded-md">

      <!-- 팀 선택 -->
      <div>
        <label class="block mb-1 text-gray-700 font-medium">선호 KBO 팀 (선택)</label>
        <select name="kboTeamNo" class="w-full px-4 py-2 border rounded-md">
          <option value="">선택 안함</option>
          <!-- 예시 팀 (DB 연동 시 서버에서 동적으로 렌더링) -->
          <option value="1">두산 베어스</option>
          <option value="2">LG 트윈스</option>
        </select>
      </div>

      <div>
        <label class="block mb-1 text-gray-700 font-medium">선호 MLB 팀 (선택)</label>
        <select name="mlbTeamNo" class="w-full px-4 py-2 border rounded-md">
          <option value="">선택 안함</option>
          <!-- 예시 팀 (DB 연동 시 서버에서 동적으로 렌더링) -->
          <option value="1">뉴욕 양키스</option>
          <option value="2">LA 다저스</option>
        </select>
      </div>

      <div>
        <button type="submit" class="w-full bg-blue-600 text-white py-2 rounded-md hover:bg-blue-700 mt-20">회원가입</button>
      </div>
    </form>
  </main>

  <!-- 푸터 -->
  <footer class="mt-20 py-6 bg-gray-100 text-center text-sm text-gray-500">
    &copy; 2025 Baseball Community. All rights reserved.
  </footer>

</body>
</html>