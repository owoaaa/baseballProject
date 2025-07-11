<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>MLB Player Stats</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link href="https://unpkg.com/tabulator-tables@5.4.4/dist/css/tabulator.min.css" rel="stylesheet">
  <script src="https://unpkg.com/tabulator-tables@5.4.4/dist/js/tabulator.min.js"></script>
</head>
<body class="bg-white text-gray-800">
  <header class="w-full shadow-sm bg-white sticky top-0 z-50">
    <div class="max-w-7xl mx-auto px-4 py-4 flex justify-between items-center">
      <h1 class="text-2xl font-bold text-blue-600">⚾ Baseball Community</h1>
      <nav class="flex items-center space-x-6 text-gray-700">
        <a href="/" title="홈" class="hover:text-blue-500">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
            <path stroke-linecap="round" stroke-linejoin="round" d="M3 9.75L12 3l9 6.75V21a1.5 1.5 0 01-1.5 1.5H4.5A1.5 1.5 0 013 21V9.75z" />
          </svg>
        </a>
        <a href="javascript:void(0);" title="로그인" class="hover:text-blue-500" onclick="event.preventDefault(); openModal();">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
            <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 9V5.25a2.25 2.25 0 00-2.25-2.25H5.25A2.25 2.25 0 003 5.25v13.5A2.25 2.25 0 005.25 21h8.25a2.25 2.25 0 002.25-2.25V15" />
            <path stroke-linecap="round" stroke-linejoin="round" d="M18 12H9m0 0l3-3m-3 3l3 3" />
          </svg>
        </a>
        <a href="/member/signUp" title="회원가입" class="hover:text-blue-500">
          <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" class="size-6">
            <path stroke-linecap="round" stroke-linejoin="round" d="M18 7.5v3m0 0v3m0-3h3m-3 0h-3m-2.25-4.125a3.375 3.375 0 1 1-6.75 0 3.375 3.375 0 0 1 6.75 0ZM3 19.235v-.11a6.375 6.375 0 0 1 12.75 0v.109A12.318 12.318 0 0 1 9.374 21c-2.331 0-4.512-.645-6.374-1.766Z" />
          </svg>
        </a>
      </nav>
    </div>
  </header>

  <main class="max-w-7xl mx-auto px-4 py-10 grid grid-cols-1 md:grid-cols-4 gap-8">
    <aside class="md:col-span-1 space-y-4">
      <h2 class="text-lg font-bold text-gray-700">📋 게시판</h2>
      <ul class="space-y-2 text-sm text-gray-700">
        <li><a href="/board/freeboard" class="block hover:text-blue-500">자유게시판</a></li>
        <li><a href="javascript:void(0);" class="block hover:text-blue-500">KBO 게시판</a></li>
        <li><a href="javascript:void(0);" class="block hover:text-blue-500">MLB 게시판</a></li>
        <li><a href="javascript:void(0);" class="block hover:text-blue-500">구단별 게시판</a></li>
        <li>
          <details class="px-4 py-2">
            <summary class="cursor-pointer hover:text-blue-500">기록</summary>
            <ul class="ml-4">
              <li><a href="/board/mlbRecord" class="block hover:underline">MLB 선수</a></li>
              <li><a href="/board/mlbStanding" class="block hover:underline">MLB 순위</a></li>
              <li><a href="/board/kboRecord" class="block hover:underline">KBO 선수</a></li>
              <li><a href="/board/kboStanding" class="block hover:underline">KBO 순위</a></li>
            </ul>
          </details>
        </li>
      </ul>
    </aside>

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
    <footer class="mt-20 py-6 bg-gray-100 text-center text-sm text-gray-500">
    &copy; 2025 Baseball Community. All rights reserved.
  </footer>

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