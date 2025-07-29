<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>게시글 상세보기</title>
  <link rel="stylesheet" href="/resources/css/style.css">
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-white text-gray-800">

  <!-- 공통 헤더 -->
  <jsp:include page="/WEB-INF/views/common/header.jsp" />

  <main class="max-w-7xl mx-auto px-4 py-10 grid grid-cols-1 md:grid-cols-4 gap-8">
    <!-- 공통 사이드바 -->
    <jsp:include page="/WEB-INF/views/common/sidebar.jsp" />

    <!-- 게시글 상세 본문 -->
    <section class="md:col-span-3 space-y-6">
      <!-- 게시판 종류 표시 -->
      <div class="text-xl font-bold mb-6">${board.boardType} 게시판</div>

      <!-- 제목 -->
      <h1 class="text-2xl font-bold">${board.boardTitle}</h1>

      <!-- 작성 정보 -->
      <div class="text-sm text-gray-500 flex justify-between">
        <span>작성자: ${board.memberNick}</span>
        <span>
          작성일: <fmt:formatDate value="${board.createDate}" pattern="yyyy년 M월 d일 HH:mm:ss" />
          <c:if test="${not empty board.updateDate}">
            | 수정일: ${board.updateDate}
          </c:if>
          | 조회수: ${board.viewCount}
          | 댓글: ${board.replyCount}
          | 좋아요: ${board.likeCount}
        </span>
      </div>

      <!-- 내용 -->
      <div class="border-t pt-6 text-base whitespace-pre-wrap leading-relaxed">
        ${board.boardContent}
      </div>

      <!-- 버튼 영역 -->
      <div class="mt-6 flex gap-2">
        <c:choose>
            <c:when test="${loginMember != null && loginMember.memberNo == board.memberNo}">
            <!-- 수정 버튼 -->
            <a href="/board/edit?no=${board.boardNo}" 
                class="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700">수정</a>

            <!-- 삭제 버튼 -->
            <form action="/board/delete" method="post" onsubmit="return confirm('정말 삭제할까요?');" style="display:inline;">
                <input type="hidden" name="no" value="${board.boardNo}" />
                <button type="submit" class="px-4 py-2 bg-red-500 text-white rounded hover:bg-red-600">삭제</button>
            </form>
            </c:when>
        </c:choose>

  <!-- 목록 버튼 (항상 보이게) -->
  <a href="/board/list?type=${board.boardType}" 
     class="px-4 py-2 bg-gray-500 text-white rounded hover:bg-gray-600">목록</a>

        <!-- 좋아요 -->
        <button id="likeBtn" class="ml-auto px-4 py-2 bg-pink-500 text-white rounded hover:bg-pink-600">
          ♥ 좋아요 <span id="likeCount">${board.likeCount}</span>
        </button>
      </div>

      <!-- 댓글 영역 -->
      <div class="mt-12">
        <h2 class="text-xl font-semibold mb-4">댓글</h2>

        <div id="replySection" class="space-y-4">
          <c:forEach var="reply" items="${replyList}">
            <div class="border-t pt-2">
              <div class="text-sm text-gray-600">
                ${reply.memberNick} | ${reply.replyCreateDate}
              </div>
              <div class="mt-1">${reply.replyContent}</div>
            </div>
          </c:forEach>
        </div>
      </div>
      <!-- 댓글 입력창 -->
    <div class="mt-8">
        <textarea id="replyContent" rows="3" class="w-full border p-2 rounded" placeholder="댓글을 입력하세요..."></textarea>
        <div class="flex justify-end mt-2">
            <button onclick="submitReply()" class="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700">댓글 등록</button>
        </div>
    </div>
    </section>
  </main>

  <!-- 공통 푸터 -->
  <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <!-- boardNo를 자바스크립트에서 사용할 수 있도록 hidden input으로 전달 -->
    <input type="hidden" id="boardNo" value="${board.boardNo}" />
    <script src="/resources/js/darkMode.js"></script>
    <script>
    // 좋아요 버튼 처리
    document.getElementById("likeBtn").addEventListener("click", () => {
        const boardNo = document.getElementById("boardNo").value;
        const boardType = "${board.boardType}";

        fetch(`/board/like?no=${boardNo}&type=${boardType}`, {
        method: "POST"
        })
        .then(res => res.json())
        .then(data => {
        document.getElementById("likeCount").innerText = data.likeCount;
        });
    });

    // 댓글 등록 처리
    function submitReply() {
        const content = document.getElementById("replyContent").value.trim();
        const boardNo = document.getElementById("boardNo").value;

        if (content === "") {
        alert("댓글을 입력하세요.");
        return;
        }

        fetch("/reply/insert", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({
            boardNo: boardNo,
            replyContent: content
        })
        })
        .then(res => res.text())
        .then(html => {
        // 댓글 영역 갱신
        document.getElementById("replySection").innerHTML = html;
        document.getElementById("replyContent").value = "";
        });
    }
    </script>

</body>
</html>