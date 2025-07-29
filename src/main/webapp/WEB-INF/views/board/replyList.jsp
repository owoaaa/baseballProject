<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<link rel="stylesheet" href="/resources/css/style.css">

<c:forEach var="reply" items="${replyList}">
  <div class="border-t pt-2">
    <div class="text-sm text-gray-600">
      ${reply.memberNick} |
      <fmt:formatDate value="${reply.replyCreateDate}" pattern="yyyy-MM-dd HH:mm:ss" />
    </div>
    <div class="mt-1">${reply.replyContent}</div>
  </div>
</c:forEach>

<c:if test="${empty replyList}">
  <div class="text-gray-400 text-sm text-center mt-4">댓글이 없습니다.</div>
</c:if>