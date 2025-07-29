<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>채팅방 목록</title>
  <link rel="stylesheet" href="/resources/css/style.css">
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-white text-gray-800">

  <jsp:include page="/WEB-INF/views/common/header.jsp" />

  <main class="max-w-7xl mx-auto px-4 py-10 grid grid-cols-1 md:grid-cols-4 gap-8">
    
    <!-- 사이드바 -->
    <jsp:include page="/WEB-INF/views/common/sidebar.jsp" />

    <!-- 메인 콘텐츠 -->
    <section class="md:col-span-3 space-y-8">
      <h2 class="text-2xl font-bold mb-6">전체 채팅방 목록</h2>

      <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-6">
        <c:forEach var="room" items="${chatRoomList}">
          <div class="bg-white rounded-lg shadow p-4 border border-gray-200 flex flex-col justify-between">
            <div class="flex items-center space-x-4">
              <div>
                <p class="text-lg font-semibold">${room.roomName}</p>
                <p class="text-sm text-gray-500">${room.participantCount}명 참여 중</p>
              </div>
            </div>

            <div class="mt-4 text-right">
                <c:choose>
                    <c:when test="${room.joined}">
                        <div class="flex justify-end gap-2">
                        <a href="/chat/room/${room.roomNo}" class="px-4 py-2 bg-blue-600 text-white text-sm rounded hover:bg-blue-700">채팅방 입장</a>
                        <button onclick="leaveRoom(${room.roomNo})" class="px-4 py-2 bg-red-100 text-red-700 text-sm rounded hover:bg-red-200">나가기</button>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <button onclick="joinRoom(${room.roomNo})" class="px-4 py-2 bg-gray-300 text-sm rounded hover:bg-gray-400">참여하기</button>
                    </c:otherwise>
                </c:choose>
            </div>
          </div>
        </c:forEach>
      </div>
    </section>
  </main>

  <jsp:include page="/WEB-INF/views/common/footer.jsp" />
  <script src="/resources/js/darkMode.js"></script>
  <script>
    function joinRoom(roomNo) {
        fetch(`/chat/join?roomNo=` + roomNo, {
        method: 'POST'
        })
        .then(res => {
        if (res.ok) {
            alert("채팅방에 참여하였습니다.");
            location.reload();
        } else {
            res.text().then(msg => alert(msg));
        }
        });
    }

    function leaveRoom(roomNo) {
        fetch(`/chat/leave?roomNo=` + roomNo, {
        method: 'POST'
        })
        .then(res => {
        if (res.ok) {
            window.location.href = "/chat/list?showLeaveMessage=true";
        } else {
            res.text().then(msg => alert(msg));
        }
        });
    }
</script>
</body>
</html>