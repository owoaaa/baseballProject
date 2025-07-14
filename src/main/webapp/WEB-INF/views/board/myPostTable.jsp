<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<table class="w-full text-sm text-left border border-gray-200">
  <thead class="bg-gray-100">
    <tr>
      <th class="px-3 py-2 border">번호</th>
      <th class="px-3 py-2 border">제목</th>
      <th class="px-3 py-2 border">작성일</th>
      <th class="px-3 py-2 border">좋아요</th>
      <th class="px-3 py-2 border">댓글 수</th>
    </tr>
  </thead>
  <tbody>
    <c:forEach var="board" items="${boardList}">
      <tr class="hover:bg-gray-50">
        <td class="px-3 py-2 border">${board.boardNo}</td>
        <td class="px-3 py-2 border">
          <a href="/board/detail?no=${board.boardNo}" class="text-blue-600 underline">${board.boardTitle}</a>
        </td>
        <td class="px-3 py-2 border">
          <fmt:formatDate value="${board.createDate}" pattern="yyyy-MM-dd" />
        </td>
        <td class="px-3 py-2 border">${board.likeCount}</td>
        <td class="px-3 py-2 border">${board.replyCount}</td>
      </tr>
    </c:forEach>

    <c:if test="${empty boardList}">
      <tr>
        <td colspan="5" class="text-center text-gray-400 py-3">작성한 글이 없습니다.</td>
      </tr>
    </c:if>
  </tbody>
</table>

<!-- 페이지네이션 -->
<div class="mt-4 flex justify-center items-center space-x-1 text-sm text-gray-700">
  <c:if test="${pi.currentPage > 1}">
    <button onclick="loadMyPosts(${pi.currentPage - 1})" class="px-2">&laquo;</button>
  </c:if>

  <c:forEach var="i" begin="${pi.startPage}" end="${pi.endPage}">
    <button onclick="loadMyPosts(${i})"
      class="px-2 ${pi.currentPage == i ? 'font-bold text-blue-600' : ''}">${i}</button>
  </c:forEach>

  <c:if test="${pi.currentPage < pi.maxPage}">
    <button onclick="loadMyPosts(${pi.currentPage + 1})" class="px-2">&raquo;</button>
  </c:if>
</div>