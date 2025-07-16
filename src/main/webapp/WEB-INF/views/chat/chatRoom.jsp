<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>${room.roomName}</title>
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
      <button onclick="leaveRoom(${room.roomNo})"
              class="px-4 py-2 text-sm bg-gray-200 text-gray-800 rounded hover:bg-gray-300">나가기</button>
    </div>

    <div id="chatArea" class="h-[400px] overflow-y-auto border rounded p-4 space-y-2 bg-gray-50"></div>

    <form onsubmit="sendMessage(); return false;" class="mt-4 flex">
      <input id="messageInput" type="text" class="flex-1 border p-2 rounded-l" placeholder="메시지를 입력하세요" required />
      <button type="submit" class="bg-blue-600 text-white px-4 rounded-r hover:bg-blue-700">전송</button>
    </form>
  </section>

</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<script>
  const roomNo = ${room.roomNo};
  const nickname = "${sessionScope.loginMember.memberNick}";

  let stompClient = null;

  function connect() {
    const socket = new SockJS("/ws-stomp");
    stompClient = Stomp.over(socket);

    stompClient.connect({}, function(frame) {
      stompClient.subscribe("/sub/chat/room/" + roomNo, function(message) {
        const msg = JSON.parse(message.body);
        showMessage(msg);
      });

      // 입장 알림은 서버에서 SYSTEM 메시지로 따로 전송됨
    });
  }

  function sendMessage() {
    const content = document.getElementById("messageInput").value.trim();
    if (!content) return;

    const message = {
      roomNo: roomNo,
      nickname: nickname,
      message: content,
      messageType: "TEXT"
    };

    stompClient.send("/pub/chat/message", {}, JSON.stringify(message));
    document.getElementById("messageInput").value = "";
  }

  function showMessage(msg) {
    const chatArea = document.getElementById("chatArea");

    const bubble = document.createElement("div");
    bubble.className = "max-w-[75%] px-4 py-2 rounded-lg";

    if (msg.messageType === "SYSTEM") {
      bubble.classList.add("mx-auto", "bg-yellow-100", "text-gray-700", "text-center", "text-sm");
      bubble.textContent = msg.message;
    } else if (msg.nickname === nickname) {
      bubble.classList.add("ml-auto", "bg-blue-200");
      bubble.textContent = msg.message;
    } else {
      bubble.classList.add("mr-auto", "bg-white", "border");
      bubble.innerHTML = `<strong>${msg.nickname}:</strong> ${msg.message}`;
    }

    chatArea.appendChild(bubble);
    chatArea.scrollTop = chatArea.scrollHeight;
  }

  window.addEventListener("DOMContentLoaded", () => {
    connect();
  });

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
</script>

</body>
</html>