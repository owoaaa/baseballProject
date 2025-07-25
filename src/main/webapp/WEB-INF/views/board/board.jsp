<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>${boardType} 게시판</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-white text-gray-800">

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<main class="max-w-7xl mx-auto px-4 py-10 grid grid-cols-1 md:grid-cols-4 gap-8">

  <jsp:include page="/WEB-INF/views/common/sidebar.jsp" />

  <section class="md:col-span-3 space-y-8">
    
    <!-- 상단 타이틀 및 글쓰기 버튼 -->
    <div class="flex justify-between items-center">
      <div class="text-xl font-bold">${boardType} 게시판</div>
      <c:if test="${not empty loginMember}">
        <a href="/board/write?type=${boardType}" 
           class="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700">
          글쓰기
        </a>
      </c:if>
    </div>

    <!-- 검색 입력 위치 조정중-->
    <div class="relative mb-4 w-full max-w-md">
      <input id="searchInput" type="text" placeholder="검색어를 입력하세요"
            class="w-full border px-4 py-2 rounded shadow focus:outline-none"
            autocomplete="off" />

      <!-- 최근 검색어 리스트 -->
      <ul id="recentSearchList"
          class="absolute top-full left-0 w-full bg-white border border-t-0 rounded-b shadow z-10 hidden">
      </ul>
    </div>

    <!-- 게시글 목록 -->
    <table class="w-full text-sm border border-gray-300">
      <thead class="bg-gray-100 text-center">
        <tr>
          <th class="w-12">번호</th>
          <th class="text-left px-2">제목</th>
          <th class="w-32">작성일</th>
          <th class="w-24">작성자</th>
          <th class="w-16">좋아요</th>
        </tr>
      </thead>
      <tbody>
        <c:if test="${empty boardList}">
          <tr>
            <td colspan="5" class="text-center py-6 text-gray-500">게시글이 없습니다.</td>
          </tr>
        </c:if>

        <c:forEach var="board" items="${boardList}">
          <tr class="text-center border-t">
            <td>${board.boardNo}</td>
            <td class="text-left px-2">
              <a href="/board/detail?no=${board.boardNo}">
                ${board.boardTitle}
                <span class="text-blue-600">[${board.replyCount}]</span>
              </a>
            </td>
            <td><fmt:formatDate value="${board.createDate}" pattern="yyyy-MM-dd" /></td>
            <td>${board.memberNick}</td>
            <td>${board.likeCount}</td>
          </tr>
        </c:forEach>
      </tbody>
    </table>

    <!-- 페이지네이션 -->
    <div class="flex justify-center mt-8">
      <ul class="flex space-x-1 text-sm">
        <c:if test="${pageInfo.startPage > 1}">
          <li><a href="?type=${boardType}&page=1" class="px-2 py-1 border">&laquo;</a></li>
          <li><a href="?type=${boardType}&page=${pageInfo.startPage - 1}" class="px-2 py-1 border">&lt;</a></li>
        </c:if>

        <c:forEach begin="${pageInfo.startPage}" end="${pageInfo.endPage}" var="p">
          <li>
            <a href="?type=${boardType}&page=${p}"
               class="px-3 py-1 border ${p == pageInfo.currentPage ? 'bg-blue-600 text-white font-bold' : ''}">
              ${p}
            </a>
          </li>
        </c:forEach>

        <c:if test="${pageInfo.endPage < pageInfo.maxPage}">
          <li><a href="?type=${boardType}&page=${pageInfo.endPage + 1}" class="px-2 py-1 border">&gt;</a></li>
          <li><a href="?type=${boardType}&page=${pageInfo.maxPage}" class="px-2 py-1 border">&raquo;</a></li>
        </c:if>
      </ul>
    </div>

  </section>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<script>
  const searchInput = document.getElementById('searchInput');
  const recentList = document.getElementById('recentSearchList');

  // 최근 검색어 불러오기
  searchInput.addEventListener('focus', () => {
    if (searchInput.value.trim() === '') {
      fetch('/board/recentSearch')
        .then(res => res.json())
        .then(data => {
          if (data.length === 0) {
            recentList.classList.add('hidden');
            return;
          }

          recentList.innerHTML = data.map(term =>
            `<li class="px-4 py-2 hover:bg-gray-100 cursor-pointer"
                  onclick="searchTerm('${term}')">${term}</li>`
          ).join('');
          recentList.classList.remove('hidden');
        });
    }
  });

  // 외부 클릭 시 닫기
  document.addEventListener('click', (e) => {
    if (!searchInput.contains(e.target) && !recentList.contains(e.target)) {
      recentList.classList.add('hidden');
    }
  });

  // 검색어 클릭 시 검색 실행
  function searchTerm(term) {
    const url = new URL(window.location.href);
    url.searchParams.set('keyword', term);
    location.href = url.toString();
  }

  // 엔터 검색 시 submit
  searchInput.addEventListener('keypress', function (e) {
    if (e.key === 'Enter') {
      searchTerm(searchInput.value.trim());
    }
  });
</script>

</body>
</html>