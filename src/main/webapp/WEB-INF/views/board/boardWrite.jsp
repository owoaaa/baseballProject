<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>글쓰기</title>
  <link rel="stylesheet" href="/resources/css/style.css">
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
    <h1 class="text-2xl font-bold">글쓰기</h1>

    <form action="/board/write" method="post" onsubmit="return submitEditorContent();">
      <!-- 게시판 종류 선택 -->
      <div>
        <label for="boardType" class="block font-medium mb-1">게시판 종류</label>
        <select id="boardType" name="boardType" class="w-40 border p-2 rounded">
          <option value="FREE">자유</option>
          <option value="KBO">KBO</option>
          <option value="MLB">MLB</option>
        </select>
      </div>

      <!-- 제목 -->
      <div>
        <label for="boardTitle" class="block font-medium mb-1">제목</label>
        <input type="text" id="boardTitle" name="boardTitle" required class="w-full border p-2 rounded" />
      </div>

      <!-- 내용 -->
      <div>
        <label class="block font-medium mb-1">내용</label>
        <div id="editor"></div>
        <!-- 실제 제출용 hidden textarea -->
        <textarea id="boardContent" name="boardContent" hidden></textarea>
      </div>

      <!-- 제출 버튼 -->
      <div class="mt-6 flex justify-end">
        <button type="submit" class="px-6 py-2 bg-blue-600 text-white rounded hover:bg-blue-700">등록</button>
      </div>
    </form>
  </section>
</main>

<!-- 공통 푸터 -->
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<script src="/resources/js/darkMode.js"></script>
<!-- Toast UI 초기화 및 전송 스크립트 -->
<script>
  const editor = new toastui.Editor({
    el: document.querySelector('#editor'),
    height: '400px',
    initialEditType: 'markdown',
    previewStyle: 'vertical'
  });

  function submitEditorContent() {
    const content = editor.getHTML();
    document.getElementById('boardContent').value = content;
    return true;
  }
</script>

</body>
</html>