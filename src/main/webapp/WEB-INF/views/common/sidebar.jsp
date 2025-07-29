<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<link rel="stylesheet" href="/resources/css/style.css">
<aside class="md:col-span-1 space-y-4">
  <h2 class="text-lg font-bold text-gray-700">📋 게시판</h2>
  <ul class="space-y-2 text-sm text-gray-700">
    <li><a href="/board/freeboard" class="block hover:text-blue-500">자유게시판</a></li>
    <li><a href="/board/list?type=KBO" class="block hover:text-blue-500">KBO 게시판</a></li>
    <li><a href="/board/list?type=MLB" class="block hover:text-blue-500">MLB 게시판</a></li>
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

  <!-- 참여 중인 채팅방 목록 추가 -->
  <c:if test="${not empty myChatRooms}">
    <div class="mt-6 px-2">
      <p class="text-sm font-semibold text-gray-600 mb-2">참여 중인 채팅방</p>
      <ul class="space-y-1 text-sm">
        <c:forEach var="room" items="${myChatRooms}">
          <li>
            <a href="/chat/room/${room.roomNo}" class="text-blue-600 hover:underline block truncate">
              ${room.roomName}
            </a>
          </li>
        </c:forEach>
      </ul>
    </div>
  </c:if>
</aside>