<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="/resources/css/style.css">

<footer class="mt-20 py-6 bg-gray-100 text-center text-sm text-gray-500">
    &copy; 2025 Baseball Community. All rights reserved.
</footer>

<c:if test="${not empty message and fn:length(fn:trim(message)) > 0}">
  <c:set var="type" value="${empty messageType ? 'success' : messageType}" />
  <div id="flashMessage"
      class="fixed top-20 left-1/2 transform -translate-x-1/2
             px-6 py-3 rounded shadow-lg z-50
             ${type eq 'success' ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800'}">
    ${fn:escapeXml(message)}
  </div>
</c:if>

<script>
  window.addEventListener('DOMContentLoaded', () => {
    const flash = document.getElementById('flashMessage');
    if (flash) {
      setTimeout(() => {
        flash.classList.add('opacity-0');
        flash.classList.add('transition-opacity');
        flash.classList.add('duration-500');
        setTimeout(() => flash.remove(), 500);
      }, 3000);
    }
  });
</script>