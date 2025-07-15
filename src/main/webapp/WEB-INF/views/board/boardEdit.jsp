<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>게시글 수정</title>
  <script src="https://cdn.tailwindcss.com"></script>

  <!-- Toast UI Editor -->
  <link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
  <script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
</head>
<body class="bg-white text-gray-800">

<!-- 공통 헤더 -->
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<main class="max-w-7xl mx-auto px-4 py-10 grid grid-cols-1 md:grid-cols-4 gap-8">

  <!-- 공통 사이드바 -->
  <jsp:include page="/WEB-INF/views/common/sidebar.jsp" />

  <!-- 본문 -->
  <section class="md:col-span-3 space-y-6">
    <h1 class="text-2xl font-bold">게시글 수정</h1>

    <form action="/board/edit" method="post" onsubmit="return submitEditorContent();">
      <input type="hidden" name="boardNo" value="${board.boardNo}" />

      <!-- 게시판 종류 -->
      <div>
        <label for="boardType" class="block font-medium mb-1">게시판 종류</label>
        <select id="boardType" name="boardType" class="w-40 border p-2 rounded" disabled>
          <option value="FREE" <c:if test="${board.boardType eq 'FREE'}">selected</c:if>>자유</option>
          <option value="KBO" <c:if test="${board.boardType eq 'KBO'}">selected</c:if>>KBO</option>
          <option value="MLB" <c:if test="${board.boardType eq 'MLB'}">selected</c:if>>MLB</option>
        </select>
      </div>

      <!-- 제목 -->
      <div>
        <label for="boardTitle" class="block font-medium mb-1">제목</label>
        <input type="text" id="boardTitle" name="boardTitle" value="${board.boardTitle}" required class="w-full border p-2 rounded" />
      </div>

      <!-- 내용 -->
      <div>
        <label class="block font-medium mb-1">내용</label>
        <div id="editor"></div>
        <textarea id="boardContent" name="boardContent" hidden></textarea>
      </div>

      <!-- 버튼 -->
      <div class="mt-6 flex justify-end space-x-2">
        <button type="submit" class="px-6 py-2 bg-blue-600 text-white rounded hover:bg-blue-700">수정</button>
        <a href="/board/detail?no=${board.boardNo}" class="px-6 py-2 bg-gray-500 text-white rounded hover:bg-gray-600">취소</a>
      </div>
    </form>
  </section>
</main>

<!-- 공통 푸터 -->
<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<!-- Toast UI 초기화 및 전송 -->
<script>
  const editor = new toastui.Editor({
    el: document.querySelector('#editor'),
    height: '400px',
    initialEditType: 'markdown',
    previewStyle: 'vertical',
    initialValue: `${board.boardContent}`
  });

  function submitEditorContent() {
    const content = editor.getHTML();
    document.getElementById('boardContent').value = content;
    return true;
  }
</script>

</body>
</html>