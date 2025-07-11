<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- MLB 리그별 순위 -->
<div class="ranking-box">
  <h2 class="text-2xl font-bold mb-6">MLB 리그별 순위</h2>

  <!-- 아메리칸 리그 -->
  <div class="mt-8">
    <h3 class="text-xl font-semibold mb-4 text-blue-700">아메리칸 리그 (AL)</h3>
    <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
      <c:forEach var="entry" items="${mlbGroupedList}">
        <c:if test="${fn:startsWith(entry.key, 'AL')}">
          <div class="mb-6">
            <h4 class="text-lg font-semibold mb-2 text-center">${entry.key}</h4>
            <table class="w-72 text-sm border border-gray-300 mx-auto">
              <thead>
                <tr class="bg-gray-100 text-center">
                  <th>팀명</th><th>승</th><th>패</th><th>게임차</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="team" items="${entry.value}">
                  <tr class="text-center border-t">
                    <td>${team.teamName}</td>
                    <td>${team.wins}</td>
                    <td>${team.losses}</td>
                    <td>${team.gamesBack}</td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>
        </c:if>
      </c:forEach>
    </div>
  </div>

  <!-- 내셔널 리그 -->
  <div class="mt-12">
    <h3 class="text-xl font-semibold mb-4 text-red-700">내셔널 리그 (NL)</h3>
    <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
      <c:forEach var="entry" items="${mlbGroupedList}">
        <c:if test="${fn:startsWith(entry.key, 'NL')}">
          <div class="mb-6">
            <h4 class="text-lg font-semibold mb-2 text-center">${entry.key}</h4>
            <table class="w-72 text-sm border border-gray-300 mx-auto">
              <thead>
                <tr class="bg-gray-100 text-center">
                  <th>팀명</th><th>승</th><th>패</th><th>게임차</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="team" items="${entry.value}">
                  <tr class="text-center border-t">
                    <td>${team.teamName}</td>
                    <td>${team.wins}</td>
                    <td>${team.losses}</td>
                    <td>${team.gamesBack}</td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>
        </c:if>
      </c:forEach>
    </div>
  </div>
</div>