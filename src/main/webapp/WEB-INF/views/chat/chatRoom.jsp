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
  let lastMessageDate = null;
  const roomNo = ${room.roomNo};
  const nickname = "${sessionScope.loginMember.memberNick}";
  console.log("nickname 변수 값:", nickname);
  let stompClient = null;

  function parseKoreanDateString(dateStr) {
    if (!dateStr) return null;
    const fixed = dateStr.replace(" ", "T");
    return new Date(fixed);
  }

  function connect() {
    const socket = new SockJS("/ws-stomp");
    stompClient = Stomp.over(socket);

    stompClient.connect({}, function (frame) {
      stompClient.subscribe("/sub/chat/room/" + roomNo, function (message) {
        const msg = JSON.parse(message.body);
        showMessage(msg);
      });
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

    // 메시지 값이 없으면 출력할 필요 없음
    if (!msg || !msg.message) return;

    // 날짜 파싱
    let sendDate;
    try {
      sendDate = new Date(msg.sendDate?.replace(" ", "T"));
      if (isNaN(sendDate.getTime())) throw new Error("Invalid date");
    } catch (e) {
      console.error("날짜 파싱 실패:", msg.sendDate);
      sendDate = new Date(); // fallback
    }

    const currentDateStr = sendDate.toISOString().split("T")[0];

    // 날짜 구분선
    if (lastMessageDate !== currentDateStr) {
      lastMessageDate = currentDateStr;

      const dateDivider = document.createElement("div");
      dateDivider.className = "text-center text-gray-500 text-sm my-4 flex items-center justify-center gap-2";
      dateDivider.innerHTML = `
        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z" />
        </svg>
        ${sendDate.getFullYear()}년 ${sendDate.getMonth() + 1}월 ${sendDate.getDate()}일 ${["일", "월", "화", "수", "목", "금", "토"][sendDate.getDay()]}요일
      `;
      chatArea.appendChild(dateDivider);
    }

    const hours = sendDate.getHours();
    const minutes = sendDate.getMinutes().toString().padStart(2, '0');
    const ampm = hours < 12 ? "오전" : "오후";
    const hour12 = hours % 12 === 0 ? 12 : hours % 12;
    const formattedTime = `${ampm} ${hour12}:${minutes}`;

    const bubble = document.createElement("div");
    bubble.className = "max-w-[75%] px-4 py-2 rounded-lg break-words";

    if (msg.messageType === "SYSTEM") {
      bubble.classList.add("mx-auto", "bg-yellow-100", "text-gray-700", "text-center", "text-sm");
      bubble.textContent = msg.message;
    } else if (msg.nickname === nickname) {
      bubble.classList.add("ml-auto", "bg-yellow-100", "text-black", "relative");
      bubble.innerHTML = `
        <div>${msg.message}</div>
        <div class="text-xs text-gray-600 text-right mt-1">${formattedTime}</div>
      `;
    } else {
      bubble.classList.add("mr-auto", "bg-white", "border", "relative");
      bubble.innerHTML = `
        <div><strong>${msg.nickname}</strong><br>${msg.message}</div>
        <div class="text-xs text-gray-500 text-right mt-1">${formattedTime}</div>
      `;
    }

    chatArea.appendChild(bubble);
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
    connect();
  });

</script>

</body>
</html>