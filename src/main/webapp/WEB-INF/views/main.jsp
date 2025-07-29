<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>Baseball Community</title>
  <link rel="stylesheet" href="/resources/css/style.css">
  <script src="https://cdn.tailwindcss.com"></script>

  <!-- 채팅방 스크롤바 보조 스타일 -->
  <style>
    .scrollbar-hide::-webkit-scrollbar {
      display: none;
    }
    .scrollbar-hide {
      -ms-overflow-style: none;
      scrollbar-width: none;
    }
  </style>
</head>
<body class="bg-white text-gray-800">

  <jsp:include page="/WEB-INF/views/common/header.jsp" />

  <main class="max-w-7xl mx-auto px-4 py-10 grid grid-cols-1 md:grid-cols-4 gap-8">
    <jsp:include page="/WEB-INF/views/common/sidebar.jsp" />

    <section class="md:col-span-3 space-y-8">
      <div class="text-center">
        <h2 class="text-3xl font-semibold mb-4">야구를 좋아하는 사람들의 커뮤니티</h2>
        <p class="text-gray-600 mb-6">실시간 게시판, 팀 정보, 경기 토론까지!</p>
        <a href="#" class="inline-block px-6 py-3 bg-blue-600 text-white rounded-full hover:bg-blue-700 transition">지금 시작하기</a>
      </div>

      <!-- 채팅방 영역 -->
      <div>
        <h2 class="text-xl font-semibold mb-4">참여 중인 채팅방</h2>

        <!-- 참여중 채팅방 슬라이드 -->
        <div class="flex overflow-x-auto space-x-4 pb-2 scrollbar-hide">
          <c:forEach var="room" items="${myChatRooms}">
            <div class="min-w-[250px] bg-white shadow rounded-lg p-4 border border-gray-200 hover:shadow-md transition cursor-pointer"
                onclick="location.href='/chat/room/${room.roomNo}'">
              
              <div>
                <p class="text-lg font-semibold truncate">${room.roomName}</p>
                <p class="text-sm text-gray-500">${room.participantCount}명 참여 중</p>
              </div>

              <div class="mt-3 text-sm text-gray-600 truncate">
                ${fn:escapeXml(room.lastMessage)}
              </div>
            </div>
          </c:forEach>
        </div>

          <!-- 전체 채팅방 더보기 버튼 -->
          <div class="text-right mt-4">
            <a href="/chat/list" class="text-blue-600 hover:underline text-sm">채팅방 더보기 &gt;</a>
          </div>
        </div>

      <!-- KBO 순위 -->
      <div class="ranking-box mt-10">
        <h2 class="text-2xl font-bold mb-6">KBO 순위</h2>
        <table class="w-full text-sm border border-gray-300">
          <thead>
            <tr class="bg-gray-100 text-center">
              <th>순위</th>
              <th>팀명</th>
              <th>경기</th>
              <th>승</th>
              <th>패</th>
              <th>무</th>
              <th>승률</th>
              <th>게임차</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="team" items="${kboList}">
              <tr class="text-center border-t">
                <td>${team.rank}</td>
                <td>${team.teamName}</td>
                <td>${team.games}</td>
                <td>${team.wins}</td>
                <td>${team.losses}</td>
                <td>${team.draws}</td>
                <td>${team.winRate}</td>
                <td>${team.gap}</td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>

      <!-- MLB 순위 출력 -->
<div class="ranking-box mt-10">
  <h2 class="text-2xl font-bold mb-6">MLB 리그별 순위</h2>

  <!-- 아메리칸 리그 -->
  <div class="mt-8">
    <h3 class="text-xl font-semibold mb-4 text-blue-700">아메리칸 리그 (AL)</h3>
    <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
      <c:forEach var="entry" items="${mlbGroupedList}">
        <c:if test="${fn:startsWith(entry.key, 'AL')}">
          <div class="mb-6">
            <h4 class="text-lg font-semibold mb-2 text-center">${entry.key}</h4>
            <table class="w-72 text-sm border border-gray-300 mx-auto">
              <thead>
                <tr class="bg-gray-100 text-center">
                  <th class="px-[10px] py-[4px]">팀명</th>
                  <th class="px-[4px] py-[4px]">승</th>
                  <th class="px-[4px] py-[4px]">패</th>
                  <th class="px-[4px] py-[4px]">게임차</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="team" items="${entry.value}">
                  <tr class="text-center border-t">
                    <td class="px-[10px] py-[4px]">${team.teamName}</td>
                    <td class="px-[4px] py-[4px]">${team.wins}</td>
                    <td class="px-[4px] py-[4px]">${team.losses}</td>
                    <td class="px-[4px] py-[4px]">${team.gamesBack}</td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>
        </c:if>
      </c:forEach>
    </div>
  </div>

  <!-- 내셔널 리그 -->
  <div class="mt-12">
    <h3 class="text-xl font-semibold mb-4 text-red-700">내셔널 리그 (NL)</h3>
    <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
      <c:forEach var="entry" items="${mlbGroupedList}">
        <c:if test="${fn:startsWith(entry.key, 'NL')}">
          <div class="mb-6">
            <h4 class="text-lg font-semibold mb-2 text-center">${entry.key}</h4>
            <table class="w-72 text-sm border border-gray-300 mx-auto">
              <thead>
                <tr class="bg-gray-100 text-center">
                  <th class="px-[10px] py-[4px]">팀명</th>
                  <th class="px-[4px] py-[4px]">승</th>
                  <th class="px-[4px] py-[4px]">패</th>
                  <th class="px-[4px] py-[4px]">게임차</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="team" items="${entry.value}">
                  <tr class="text-center border-t">
                    <td class="px-[10px] py-[4px]">${team.teamName}</td>
                    <td class="px-[4px] py-[4px]">${team.wins}</td>
                    <td class="px-[4px] py-[4px]">${team.losses}</td>
                    <td class="px-[4px] py-[4px]">${team.gamesBack}</td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>
        </c:if>
      </c:forEach>
    </div>
  </div>
</div>

    </section>
  </main>

  <!-- 로그인 모달 -->
  <div id="loginModal" class="fixed inset-0 flex items-center justify-center bg-black bg-opacity-50 z-50 hidden">
    <div class="bg-white p-6 rounded-lg shadow-lg w-full max-w-sm relative">
      <button type="button" onclick="closeModal()" class="absolute top-2 right-2 text-gray-500 hover:text-gray-800 text-xl">&times;</button>
      <h2 class="text-xl font-bold mb-4 text-center">로그인</h2>
      <form action="/member/login" method="post" class="space-y-4">
        <div>
          <label for="memberId" class="block text-sm font-medium text-gray-700">아이디</label>
          <input type="text" id="memberId" name="memberId" required class="mt-1 block w-full border border-gray-300 rounded-md shadow-sm p-2" />
        </div>
        <div>
          <label for="memberPw" class="block text-sm font-medium text-gray-700">비밀번호</label>
          <input type="password" id="memberPw" name="memberPw" required class="mt-1 block w-full border border-gray-300 rounded-md shadow-sm p-2" />
        </div>
        <div class="flex justify-end">
          <button type="submit" class="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700">로그인</button>
        </div>
        <c:if test="${param.error == '1'}">
          <p class="text-red-600 text-sm text-center mt-2">아이디 또는 비밀번호가 잘못되었습니다.</p>
        </c:if>
      </form>
    </div>
  </div>

  <jsp:include page="/WEB-INF/views/common/footer.jsp" />
  <script src="/resources/js/darkMode.js"></script>
  <script>
  function openModal() {
    document.getElementById('loginModal').classList.remove('hidden');
  }
  function closeModal() {
    document.getElementById('loginModal').classList.add('hidden');
  }

  window.addEventListener('DOMContentLoaded', () => {
    const url = new URL(window.location.href);
    if (url.searchParams.get('showLoginModal') === 'true') {
      openModal();
    }
  });
</script>


</body>
</html>