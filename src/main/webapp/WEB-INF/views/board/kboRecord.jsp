<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>KBO Player Stats</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link href="https://unpkg.com/tabulator-tables@5.4.4/dist/css/tabulator.min.css" rel="stylesheet">
  <script src="https://unpkg.com/tabulator-tables@5.4.4/dist/js/tabulator.min.js"></script>
</head>
<body class="bg-white text-gray-800">

  <!-- 공통 헤더 -->
  <jsp:include page="/WEB-INF/views/common/header.jsp" />
  <main class="max-w-7xl mx-auto px-4 py-10 grid grid-cols-1 md:grid-cols-4 gap-8">
    <!-- 왼쪽 사이드바 -->
    <jsp:include page="/WEB-INF/views/common/sidebar.jsp" />

    <!-- 오른쪽 콘텐츠 영역 -->
    <section class="md:col-span-3 space-y-10">
      <h1 class="text-2xl font-bold">KBO 타자 기록</h1>
      <div id="kbo-hitter-table"></div>

      <h1 class="text-2xl font-bold">KBO 투수 기록</h1>
      <div id="kbo-pitcher-table"></div>
    </section>
  </main>

  <jsp:include page="/WEB-INF/views/common/footer.jsp" />

  <script>
    const hitterData = ${kboHittersJson};
    const pitcherData = ${kboPitchersJson};

    new Tabulator("#kbo-hitter-table", {
      data: hitterData,
      layout: "fitColumns",
      pagination: "local",
      paginationSize: 20,
      columns: [
        {title: "선수명", field: "name"},
        {title: "AVG", field: "avg"},
        {title: "PA", field: "pa"},
        {title: "AB", field: "ab"},
        {title: "R", field: "r"},
        {title: "H", field: "hits"},
        {title: "HR", field: "hr"},
        {title: "RBI", field: "rbi"},
        {title: "OBP", field: "obp"},
        {title: "SLG", field: "slg"},
        {title: "OPS", field: "ops"},
      ]
    });

    new Tabulator("#kbo-pitcher-table", {
      data: pitcherData,
      layout: "fitColumns",
      pagination: "local",
      paginationSize: 20,
      columns: [
        {title: "선수명", field: "name"},
        {title: "ERA", field: "era"},
        {title: "G", field: "games"},
        {title: "W", field: "wins"},
        {title: "L", field: "losses"},
        {title: "SV", field: "saves"},
        {title: "IP", field: "innings"},
        {title: "H", field: "hitsAllowed"},
        {title: "BB", field: "walks"},
        {title: "SO", field: "strikeouts"},
        {title: "WHIP", field: "whip"},
      ]
    });
  </script>
</body>
</html>