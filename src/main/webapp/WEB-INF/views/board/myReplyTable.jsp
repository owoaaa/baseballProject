<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<table class="w-full text-sm text-left border border-gray-200">
  <thead class="bg-gray-100">
    <tr>
      <th class="px-3 py-2 border">번호</th>
      <th class="px-3 py-2 border">내용</th>
      <th class="px-3 py-2 border">작성일</th>
      <th class="px-3 py-2 border">작성된 게시글</th>
    </tr>
  </thead>
  <tbody>
    <c:forEach var="reply" items="${replyList}">
      <tr class="hover:bg-gray-50">
        <td class="px-3 py-2 border">${reply.replyNo}</td>
        <td class="px-3 py-2 border">${reply.replyContent}</td>
        <td class="px-3 py-2 border">
          <fmt:formatDate value="${reply.replyCreateDate}" pattern="yyyy-MM-dd" />
        </td>
        <td class="px-3 py-2 border">
          <a href="/board/detail?no=${reply.board.boardNo}" class="text-blue-600 underline">
            ${reply.board.boardTitle}
          </a>
        </td>
      </tr>
    </c:forEach>

    <c:if test="${empty replyList}">
      <tr>
        <td colspan="4" class="text-center text-gray-400 py-3">작성한 댓글이 없습니다.</td>
      </tr>
    </c:if>
  </tbody>
</table>

<!-- 페이지네이션 -->
<div class="mt-4 flex justify-center items-center space-x-1 text-sm text-gray-700">
  <c:if test="${pi.currentPage > 1}">
    <button onclick="loadMyReplies(${pi.currentPage - 1})" class="px-2">&laquo;</button>
  </c:if>

  <c:forEach var="i" begin="${pi.startPage}" end="${pi.endPage}">
    <button onclick="loadMyReplies(${i})"
      class="px-2 ${pi.currentPage == i ? 'font-bold text-blue-600' : ''}">${i}</button>
  </c:forEach>

  <c:if test="${pi.currentPage < pi.maxPage}">
    <button onclick="loadMyReplies(${pi.currentPage + 1})" class="px-2">&raquo;</button>
  </c:if>
</div>