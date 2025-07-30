<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>Baseball Community</title>
  <link rel="stylesheet" href="/resources/css/style.css">
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-white text-gray-800">

  <!-- 공통 헤더 -->
  <jsp:include page="/WEB-INF/views/common/header.jsp" />

  <!-- 본문 영역 -->
  <main class="max-w-7xl mx-auto px-4 py-10 grid grid-cols-1 md:grid-cols-4 gap-8">
    
    <!-- 왼쪽 사이드바 -->
    <jsp:include page="/WEB-INF/views/common/sidebar.jsp" />


    <!-- 오른쪽 콘텐츠 영역 -->
    <section class="md:col-span-3 space-y-8">
      <jsp:include page="${contentPage}" />
    </section>
  </main>

  <jsp:include page="/WEB-INF/views/common/footer.jsp" />
  <script src="/resources/js/darkMode.js"></script>

  <!-- 로그인 모달 스크립트 -->
  <script>
    function openModal() {
      document.getElementById('loginModal').classList.remove('hidden');
    }
    function closeModal() {
      document.getElementById('loginModal').classList.add('hidden');
    }
  </script>

</body>
</html>