<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="/resources/css/style.css">

<div class="ranking-box">
  <h2 class="text-2xl font-bold mb-6">KBO 순위</h2>
    <table class="w-full text-sm border border-gray-300">
        <thead>
        <tr class="bg-gray-100 text-center">
            <th>순위</th>
            <th>팀명</th>
            <th>경기</th>
            <th>승</th>
            <th>패</th>
            <th>무</th>
            <th>승률</th>
            <th>게임차</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="team" items="${kboList}">
            <tr class="text-center border-t">
            <td>${team.rank}</td>
            <td>${team.teamName}</td>
            <td>${team.games}</td>
            <td>${team.wins}</td>
            <td>${team.losses}</td>
            <td>${team.draws}</td>
            <td>${team.winRate}</td>
            <td>${team.gap}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<script src="/resources/js/darkMode.js"></script>