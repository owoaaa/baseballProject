<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>MLB Player Stats</title>
  <link rel="stylesheet" href="/resources/css/style.css">
  <script src="https://cdn.tailwindcss.com"></script>
  <link href="https://unpkg.com/tabulator-tables@5.4.4/dist/css/tabulator.min.css" rel="stylesheet">
  <script src="https://unpkg.com/tabulator-tables@5.4.4/dist/js/tabulator.min.js"></script>
</head>
<body class="bg-white text-gray-800">
  <jsp:include page="/WEB-INF/views/common/header.jsp" />

  <main class="max-w-7xl mx-auto px-4 py-10 grid grid-cols-1 md:grid-cols-4 gap-8">
    <jsp:include page="/WEB-INF/views/common/sidebar.jsp" />

    <section class="md:col-span-3 space-y-8">
      <div class="max-w-7xl mx-auto px-4">
        <h2 class="text-xl font-semibold mb-4">MLB 타자 기록 (2025 시즌)</h2>
        <div class="mb-4">
          <input type="text" id="search-name" placeholder="선수 이름을 검색하세요" class="border border-gray-300 rounded px-3 py-2 w-full max-w-md focus:outline-none focus:ring-2 focus:ring-blue-400">
          <div class="flex flex-wrap items-center gap-4 mb-4 mt-4">
            <label class="flex items-center gap-2">타율(AVG) ≥ <input type="number" step="0.001" id="filter-avg" placeholder="0.3" class="border px-2 py-1 rounded w-20"></label>
            <label class="flex items-center gap-2">홈런(HR) ≥ <input type="number" id="filter-hr" placeholder="10" class="border px-2 py-1 rounded w-20"></label>
            <button id="apply-filter" class="bg-blue-500 text-white px-4 py-1 rounded hover:bg-blue-600">필터 적용</button>
            <button id="reset-filter" class="bg-gray-400 text-white px-4 py-1 rounded hover:bg-gray-500">초기화</button>
          </div>
        </div>
        <div id="mlbTable" class="overflow-x-auto"></div>
      </div>

      <div class="max-w-7xl mx-auto px-4 mt-20">
        <h2 class="text-xl font-semibold mb-4">MLB 투수 기록 (2025 시즌)</h2>
        <div id="mlbPitcherTable" class="overflow-x-auto"></div>
      </div>
    </section>
  </main>
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <script src="/resources/js/darkMode.js"></script>
<script>
  const tableData = [
    <c:forEach var="p" items="${mlbList}" varStatus="status">
    {
      name: "${p.name}",
      avg: "${p.avg}",
      hr: ${p.homeRuns},
      rbi: ${p.rbi},
      runs: ${p.runs},
      hits: ${p.hits},
      ab: ${p.atBats},
      bb: ${p.baseOnBalls},
      so: ${p.strikeOuts},
      sb: ${p.stolenBases},
      obp: "${p.obp}",
      slg: "${p.slg}",
      ops: "${p.ops}",
      doubles: ${p.doubles},
      triples: ${p.triples},
      pa: ${p.plateAppearances},
      games: ${p.gamesPlayed},
      sf: ${p.sacFlies},
      tb: ${p.totalBases},
      goao: "${p.groundOutsToAirouts}"
    }<c:if test="${!status.last}">,</c:if>
    </c:forEach>
  ];

  const pitcherData = [
    <c:forEach var="p" items="${mlbPitchers}" varStatus="status">
    {
      name: "${p.name}",
      era: "${p.era}",
      games: ${p.gamesPlayed},
      gs: ${p.gamesStarted},
      wins: ${p.wins},
      losses: ${p.losses},
      saves: ${p.saves},
      ip: "${p.inningsPitched}",
      so: ${p.strikeOuts},
      bb: ${p.baseOnBalls},
      hits: ${p.hits},
      whip: "${p.whip}"
    }<c:if test="${!status.last}">,</c:if>
    </c:forEach>
  ];

  const table = new Tabulator("#mlbTable", {
    data: tableData,
    layout: "fitDataFill",
    pagination: "local",
    paginationSize: 15,
    movableColumns: true,
    height: "auto",
    columns: [
      { title: "Name", field: "name" },
      { title: "AVG", field: "avg", hozAlign: "center" },
      { title: "HR", field: "hr", hozAlign: "center" },
      { title: "RBI", field: "rbi", hozAlign: "center" },
      { title: "R", field: "runs", hozAlign: "center" },
      { title: "H", field: "hits", hozAlign: "center" },
      { title: "AB", field: "ab", hozAlign: "center" },
      { title: "BB", field: "bb", hozAlign: "center" },
      { title: "SO", field: "so", hozAlign: "center" },
      { title: "SB", field: "sb", hozAlign: "center" },
      { title: "OBP", field: "obp", hozAlign: "center" },
      { title: "SLG", field: "slg", hozAlign: "center" },
      { title: "OPS", field: "ops", hozAlign: "center" },
      { title: "2B", field: "doubles", hozAlign: "center" },
      { title: "3B", field: "triples", hozAlign: "center" },
      { title: "PA", field: "pa", hozAlign: "center" },
      { title: "G", field: "games", hozAlign: "center" },
      { title: "SF", field: "sf", hozAlign: "center" },
      { title: "TB", field: "tb", hozAlign: "center" },
      { title: "GO/AO", field: "goao", hozAlign: "center" }
    ]
  });

  const pitcherTable = new Tabulator("#mlbPitcherTable", {
    data: pitcherData,
    layout: "fitDataFill",
    pagination: "local",
    paginationSize: 15,
    movableColumns: true,
    height: "auto",
    columns: [
      { title: "Name", field: "name" },
      { title: "ERA", field: "era", hozAlign: "center" },
      { title: "G", field: "games", hozAlign: "center" },
      { title: "GS", field: "gs", hozAlign: "center" },
      { title: "W", field: "wins", hozAlign: "center" },
      { title: "L", field: "losses", hozAlign: "center" },
      { title: "SV", field: "saves", hozAlign: "center" },
      { title: "IP", field: "ip", hozAlign: "center" },
      { title: "SO", field: "so", hozAlign: "center" },
      { title: "BB", field: "bb", hozAlign: "center" },
      { title: "H", field: "hits", hozAlign: "center" },
      { title: "WHIP", field: "whip", hozAlign: "center" }
    ]
  });

  document.getElementById("search-name").addEventListener("keyup", function () {
    const keyword = this.value;
    table.setFilter("name", "like", keyword);
  });

  document.getElementById("apply-filter").addEventListener("click", function () {
    const avg = parseFloat(document.getElementById("filter-avg").value);
    const hr = parseInt(document.getElementById("filter-hr").value);
    const filters = [];
    if (!isNaN(avg)) filters.push({ field: "avg", type: ">=", value: avg });
    if (!isNaN(hr)) filters.push({ field: "hr", type: ">=", value: hr });
    table.clearFilter();
    if (filters.length > 0) table.setFilter(filters);
  });

  document.getElementById("reset-filter").addEventListener("click", function () {
    document.getElementById("filter-avg").value = "";
    document.getElementById("filter-hr").value = "";
    table.clearFilter();
  });

  let isPreventingScroll = false;
let savedScrollPos = 0;

// 스크롤 이벤트를 임시로 막는 함수
function preventScroll(e) {
  if (isPreventingScroll) {
    window.scrollTo(0, savedScrollPos);
    e.preventDefault();
    return false;
  }
}

// 타자 테이블 정렬 이벤트
table.on("dataSorting", function(){
  savedScrollPos = window.pageYOffset || document.documentElement.scrollTop;
  isPreventingScroll = true;
  
  // 스크롤 이벤트 리스너 추가
  window.addEventListener('scroll', preventScroll, { passive: false });
  document.addEventListener('scroll', preventScroll, { passive: false });
});

table.on("dataSorted", function(){
  // 짧은 지연 후 스크롤 방지 해제
  setTimeout(() => {
    isPreventingScroll = false;
    window.removeEventListener('scroll', preventScroll);
    document.removeEventListener('scroll', preventScroll);
  }, 50);
});

// 투수 테이블 정렬 이벤트
pitcherTable.on("dataSorting", function(){
  savedScrollPos = window.pageYOffset || document.documentElement.scrollTop;
  isPreventingScroll = true;
  
  window.addEventListener('scroll', preventScroll, { passive: false });
  document.addEventListener('scroll', preventScroll, { passive: false });
});

pitcherTable.on("dataSorted", function(){
  setTimeout(() => {
    isPreventingScroll = false;
    window.removeEventListener('scroll', preventScroll);
    document.removeEventListener('scroll', preventScroll);
  }, 50);
});
</script>
</body>
</html>