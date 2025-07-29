<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>${room.roomName}</title>
  <link rel="stylesheet" href="/resources/css/style.css">
  <script src="https://cdn.tailwindcss.com"></script>
  <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/stompjs@2.3.3/lib/stomp.min.js"></script>
</head>
<body class="bg-gray-100 text-gray-800">

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<main class="max-w-7xl mx-auto px-4 py-10 grid grid-cols-1 md:grid-cols-4 gap-8">

  <!-- 사이드바 -->
  <jsp:include page="/WEB-INF/views/common/sidebar.jsp" />

  

  <!-- 채팅 영역 -->
  <section class="md:col-span-3 space-y-4 bg-white rounded shadow p-4">
    
  <div class="flex justify-between items-center mb-6">
    <h2 class="text-2xl font-bold">${room.roomName}</h2>
    <div class="flex gap-2">
      <a href="/chat/list" class="px-4 py-2 bg-blue-600 text-white text-sm rounded hover:bg-blue-700">
        채팅방 목록으로
      </a>
      <button onclick="leaveRoom(${room.roomNo})"
              class="px-4 py-2 text-sm bg-gray-200 text-gray-800 rounded hover:bg-gray-300">
        나가기
      </button>
    </div>
  </div>

  <div id="chatArea" class="h-[400px] overflow-y-auto border rounded p-4 space-y-2 bg-gray-50"></div>

  <form onsubmit="sendMessage(); return false;" class="mt-4 flex">
    <input id="messageInput" type="text" class="flex-1 border p-2 rounded-l" placeholder="메시지를 입력하세요" required />
    <button type="submit" class="bg-blue-600 text-white px-4 rounded-r hover:bg-blue-700">전송</button>
  </form>

</section>

</main>

<c:set var="message" value="" scope="request" />
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<script src="/resources/js/darkMode.js"></script>
<script>
  const messageList = [
    <c:forEach items="${messageList}" var="msg" varStatus="loop">
      {
        messageNo: ${msg.messageNo},
        roomNo: ${msg.roomNo},
        memberNo: ${msg.memberNo},
        nickname: '<c:out value="${msg.nickname}" />',
        message: '<c:out value="${msg.message}" />',
        sendDate: "${msg.sendDate}",
        messageType: "${msg.messageType}"
      }<c:if test="${!loop.last}">,</c:if>
    </c:forEach>
  ];
</script>

<script>
  let lastMessageDate = null;
  const roomNo = ${room.roomNo};
  const memberNo = "${sessionScope.loginMember.memberNo}";
  const nickname = "${sessionScope.loginMember.memberNick}";
  console.log("nickname 변수 값:", nickname);
  let stompClient = null;

  // JSP에서 전달받은 기존 메시지들을 화면에 표시하는 함수

  function parseKoreanDateString(dateStr) {
    if (!dateStr) return null;
    const fixed = dateStr.replace(" ", "T");
    return new Date(fixed);
  }

  function connect() {
    const socket = new SockJS("/ws-stomp");
    stompClient = Stomp.over(socket);

    stompClient.connect({}, function (frame) {
      stompClient.subscribe("/sub/chat/room/" + roomNo, function (socketMessage) {  // message → socketMessage로 변경
        const msg = JSON.parse(socketMessage.body);
        showMessage(msg);
      });
    });
  }

  function sendMessage() {
    const content = document.getElementById("messageInput").value.trim();
    if (!content) return;

    const messageData = {  // message → messageData로 변경
      roomNo: roomNo,
      memberNo: memberNo,
      nickname: nickname,
      message: content,
      messageType: "TEXT"
    };

    stompClient.send("/pub/chat/message", {}, JSON.stringify(messageData));
    document.getElementById("messageInput").value = "";
  }

  function showMessage(msg) {
      console.log("받은 메시지:", msg);
      console.log("현재 사용자 memberNo:", memberNo);
      console.log("메시지 보낸 사용자 memberNo:", msg.memberNo);
      console.log("msg.messageType:", msg.messageType);  // 이 줄 추가
    console.log("msg.messageType === 'SYSTEM':", msg.messageType === "SYSTEM");
      
      const chatArea = document.getElementById("chatArea");
      if (!chatArea) {
          console.error("chatArea 요소를 찾을 수 없습니다!");
          return;
      }

      // 날짜 포맷 처리
      const rawDate = msg.sendDate;
      const isoDate = rawDate ? rawDate.replace(" ", "T") : null;
      const dateObj = isoDate ? new Date(isoDate) : new Date();
      const formattedTime = dateObj.toLocaleTimeString("ko-KR", { hour: '2-digit', minute: '2-digit' });
      
      // 날짜만 추출 (YYYY-MM-DD 형식)
      const messageDate = dateObj.toISOString().split('T')[0];
      
      // 날짜가 바뀌었으면 날짜 표시 (기존 lastMessageDate 변수 사용)
      if (lastMessageDate !== messageDate) {
          const dateDisplayHtml = 
            '<div style="text-align: center; margin: 20px 0 10px 0;">' +
              '<span style="background-color: #f3f4f6; padding: 4px 12px; border-radius: 12px; font-size: 12px; color: #666;">' +
                dateObj.toLocaleDateString("ko-KR", { year: 'numeric', month: 'long', day: 'numeric' }) +
              '</span>' +
            '</div>';
          chatArea.insertAdjacentHTML("beforeend", dateDisplayHtml);
          lastMessageDate = messageDate;
      }

      // 시스템 메시지인 경우 (입장/퇴장 메시지)
      if (msg.messageType === "SYSTEM") {
          const systemMessageHtml = 
            '<div style="text-align: center; margin: 8px 0;">' +
              '<span style="background-color: #e5e7eb; padding: 6px 12px; border-radius: 12px; font-size: 12px; color: #6b7280;">' +
                (msg.message || '시스템 메시지') +
              '</span>' +
            '</div>';
          chatArea.insertAdjacentHTML("beforeend", systemMessageHtml);
          chatArea.scrollTop = chatArea.scrollHeight;
          return;
      }

      // 일반 채팅 메시지 처리
      const isOwnMessage = String(msg.memberNo) === String(memberNo);
      
      console.log("isOwnMessage:", isOwnMessage);
      console.log("msg.nickname:", msg.nickname);
      console.log("msg.message:", msg.message);

      // 카카오톡 스타일 메시지 (문자열 연결 사용)
      let messageHtml = '<div style="margin-bottom: 8px; ' + (isOwnMessage ? 'text-align: right;' : 'text-align: left;') + '">';
      
      // 상대방 메시지인 경우에만 닉네임 표시
      if (!isOwnMessage) {
          messageHtml += '<div style="font-size: 12px; color: #666; margin-bottom: 4px; margin-left: 8px;">' + (msg.nickname || '알 수 없음') + '</div>';
      }
      
      messageHtml += '<div style="display: inline-block; max-width: 250px; padding: 8px 12px; border-radius: 18px; word-wrap: break-word; ' + 
                    (isOwnMessage ? 'background-color: #007bff; color: white;' : 'background-color: #f1f3f4; color: black;') + '">' +
                    (msg.message || '메시지 없음') +
                    '</div>';
      
      messageHtml += '<div style="font-size: 10px; color: #999; margin-top: 2px; ' + 
                    (isOwnMessage ? 'margin-right: 8px;' : 'margin-left: 8px;') + '">' + 
                    formattedTime + 
                    '</div>';
      
      messageHtml += '</div>';

      chatArea.insertAdjacentHTML("beforeend", messageHtml);
      chatArea.scrollTop = chatArea.scrollHeight;
  }

  function leaveRoom(roomNo) {
    fetch("/chat/leave?roomNo=" + roomNo, {
      method: "POST"
    })
      .then(res => {
        if (res.ok) {
          window.location.href = "/chat/list";
        } else {
          res.text().then(msg => alert(msg));
        }
      });
  }

  window.addEventListener("DOMContentLoaded", () => {
    // 기존 메시지 표시
    messageList.forEach(showMessage);
    connect();
  });

</script>

</body>
</html>