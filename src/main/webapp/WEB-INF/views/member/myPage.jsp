<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>마이페이지</title>
  <script src="https://cdn.tailwindcss.com"></script>
    <script>
        function showContent(sectionId) {
        const sections = document.querySelectorAll('.content-section');
        sections.forEach(sec => sec.classList.add('hidden'));
        document.getElementById(sectionId).classList.remove('hidden');
        }

        function toggleMenu(menuId) {
        const el = document.getElementById(menuId);
        el.classList.toggle('hidden');
        }

        // 다크모드
        function toggleDarkMode() {
            document.documentElement.classList.toggle('dark');
        }

        // 회원 탈퇴
        const agreeCheckbox = document.getElementById('agree');
        const passwordInput = document.getElementById('currentPassword');
        const withdrawBtn = document.getElementById('withdrawBtn');

        function checkWithdrawConditions() {
            const agreed = agreeCheckbox.checked;
            const passwordFilled = passwordInput.value.trim().length > 0;
            withdrawBtn.disabled = !(agreed && passwordFilled);
            withdrawBtn.classList.toggle('opacity-50', withdrawBtn.disabled);
            withdrawBtn.classList.toggle('cursor-not-allowed', withdrawBtn.disabled);
        }

        agreeCheckbox.addEventListener('change', checkWithdrawConditions);
        passwordInput.addEventListener('input', checkWithdrawConditions);

    </script>
    <style>
        html.dark body {
            background-color: #1a202c;
            color: #e2e8f0;
        }
        html.dark .bg-white {
            background-color: #2d3748 !important;
        }
        html.dark .text-gray-800 {
            color: #e2e8f0 !important;
        }
        html.dark .border-gray-200 {
            border-color: #4a5568 !important;
        }
        html.dark .bg-gray-100 {
            background-color: #4a5568 !important;
        }
        html.dark .text-gray-700 {
            color: #cbd5e0 !important;
        }
    </style>
</head>
<body class="bg-gray-50 text-gray-800">

<!-- 상단 네비게이션 -->
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<main class="max-w-7xl mx-auto mt-8 flex">
  <!-- 사이드바 -->
  <aside class="w-1/4 pr-6">
    <ul class="space-y-4 text-base">
      <li>
        <button onclick="toggleMenu('menu-home')" class="flex items-center gap-3 w-full text-left px-4 py-2 bg-white rounded-lg shadow-sm hover:bg-blue-50 transition">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-blue-500" fill="none"
               viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
            <path stroke-linecap="round" stroke-linejoin="round"
                  d="M3 9.75L12 3l9 6.75V21a1.5 1.5 0 01-1.5 1.5H4.5A1.5 1.5 0 013 21V9.75z" />
          </svg>
          <span class="text-gray-800 font-medium">마이페이지 홈</span>
        </button>
        <ul id="menu-home" class="ml-8 mt-2 space-y-1 hidden">
          <li><button onclick="showContent('editInfo')" class="text-gray-700 hover:text-blue-600 block">- 내 정보 수정</button></li>
          <li><button onclick="showContent('changePw')" class="text-gray-700 hover:text-blue-600 block">- 비밀번호 변경</button></li>
        </ul>
      </li>

      <li>
        <button onclick="toggleMenu('menu-activity')" class="flex items-center gap-3 w-full text-left px-4 py-2 bg-white rounded-lg shadow-sm hover:bg-blue-50 transition">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-blue-500" fill="none"
               viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
            <path stroke-linecap="round" stroke-linejoin="round" d="M4 6h16M4 12h16M4 18h16" />
          </svg>
          <span class="text-gray-800 font-medium">내 활동</span>
        </button>
        <ul id="menu-activity" class="ml-8 mt-2 space-y-1 hidden">
          <li><button onclick="showContent('myPosts')" class="text-gray-700 hover:text-blue-600 block">- 내가 쓴 글</button></li>
          <li><button onclick="showContent('myComments')" class="text-gray-700 hover:text-blue-600 block">- 내가 쓴 댓글</button></li>
          <li><button onclick="showContent('myLikes')" class="text-gray-700 hover:text-blue-600 block">- 좋아요 누른 글</button></li>
        </ul>
      </li>

      <li>
        <button onclick="toggleMenu('menu-point')" class="flex items-center gap-3 w-full text-left px-4 py-2 bg-white rounded-lg shadow-sm hover:bg-blue-50 transition">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-blue-500" fill="none"
               viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
            <path stroke-linecap="round" stroke-linejoin="round"
                  d="M11 11V7m0 8v-2m-7 4h14a2 2 0 002-2V7a2 2 0 00-2-2H4a2 2 0 00-2 2v8a2 2 0 002 2z" />
          </svg>
          <span class="text-gray-800 font-medium">포인트 / 등급</span>
        </button>
        <ul id="menu-point" class="ml-8 mt-2 space-y-1 hidden">
          <li><button onclick="showContent('pointHistory')" class="text-gray-700 hover:text-blue-600 block">- 포인트 내역</button></li>
          <li><button onclick="showContent('levelInfo')" class="text-gray-700 hover:text-blue-600 block">- 등급 기준 보기</button></li>
        </ul>
      </li>

      <li>
        <button onclick="toggleMenu('menu-setting')" class="flex items-center gap-3 w-full text-left px-4 py-2 bg-white rounded-lg shadow-sm hover:bg-blue-50 transition">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-blue-500" fill="none"
               viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
            <path stroke-linecap="round" stroke-linejoin="round"
                  d="M11.25 3.375c.966 0 1.75.784 1.75 1.75v.688a7.5 7.5 0 014.563 4.562h.687a1.75 1.75 0 010 3.5h-.688a7.5 7.5 0 01-4.562 4.563v.687a1.75 1.75 0 01-3.5 0v-.688a7.5 7.5 0 01-4.563-4.562H3.375a1.75 1.75 0 010-3.5h.688a7.5 7.5 0 014.562-4.563v-.687c0-.966.784-1.75 1.75-1.75z" />
          </svg>
          <span class="text-gray-800 font-medium">설정</span>
        </button>
        <ul id="menu-setting" class="ml-8 mt-2 space-y-1 hidden">
          <li><button onclick="showContent('alarmSetting')" class="text-gray-700 hover:text-blue-600 block">- 알림 설정</button></li>
          <li><button onclick="showContent('darkMode')" class="text-gray-700 hover:text-blue-600 block">- 다크모드 전환</button></li>
        </ul>
      </li>

      <li>
        <button onclick="toggleMenu('menu-etc')" class="flex items-center gap-3 w-full text-left px-4 py-2 bg-white rounded-lg shadow-sm hover:bg-red-50 transition">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-red-500" fill="none"
               viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
            <path stroke-linecap="round" stroke-linejoin="round"
                  d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1H9a1 1 0 00-1 1v3m12 0H4" />
          </svg>
          <span class="text-red-600 font-medium">기타</span>
        </button>
        <ul id="menu-etc" class="ml-8 mt-2 space-y-1 hidden">
          <li><button onclick="showContent('withdraw')" class="text-red-600 hover:text-red-700 block">- 회원 탈퇴</button></li>
        </ul>
      </li>
    </ul>
  </aside>

  <!-- 본문 콘텐츠 -->
  <section class="w-3/4 bg-white p-6 rounded shadow-sm space-y-6">
    <div id="home" class="content-section space-y-6">
    <h2 class="text-2xl font-semibold">마이페이지</h2>

    <!-- 회원 기본 정보 -->
    <div class="bg-gray-100 p-4 rounded shadow-sm">
      <h3 class="text-lg font-semibold mb-2">회원 정보</h3>
      <ul class="space-y-1 text-sm">
        <li><strong>닉네임:</strong> <span class="text-gray-700">야바에새봄</span></li>
        <li><strong>이메일:</strong> <span class="text-gray-700">yabae@example.com</span></li>
        <li><strong>가입일:</strong> <span class="text-gray-700">2025-06-01</span></li>
        <li><strong>마지막 로그인:</strong> <span class="text-gray-700">2025-07-08 12:41</span></li>
      </ul>
    </div>

    <!-- 포인트/등급 요약 -->
    <div class="bg-white p-4 rounded shadow-sm border border-gray-200">
      <h3 class="text-lg font-semibold mb-2">포인트 및 등급</h3>
      <div class="flex items-center justify-between">
        <div>
          <p><strong>현재 포인트:</strong> <span class="text-blue-600 font-bold">1,240P</span></p>
          <p><strong>현재 등급:</strong> <span class="text-green-600 font-bold">프로</span></p>
        </div>
        <div class="w-1/2">
          <div class="w-full bg-gray-200 rounded-full h-4">
            <div class="bg-blue-500 h-4 rounded-full" style="width: 62%;"></div>
          </div>
          <p class="text-xs text-gray-500 mt-1 text-right">다음 등급까지 380P 남음</p>
        </div>
      </div>
    </div>

    <!-- 최근 활동 -->
    <div class="bg-gray-50 p-4 rounded shadow-sm">
      <h3 class="text-lg font-semibold mb-2">최근 활동</h3>
      <ul class="list-disc list-inside text-sm text-gray-700 space-y-1">
        <li>2025-07-07 [자유게시판] "오늘 경기 재밌었음ㅋㅋ"</li>
        <li>2025-07-06 [KBO게시판] "두산 요즘 분위기 좋다"</li>
        <li>2025-07-05 댓글 작성 "ㅋㅋㅋ 인정"</li>
      </ul>
    </div>

    <!-- 알림 -->
    <div class="bg-white p-4 rounded shadow-sm border border-gray-200">
      <h3 class="text-lg font-semibold mb-2">공지 및 알림</h3>
      <ul class="text-sm text-gray-700 space-y-1">
        <li><a href="#" class="text-blue-600 hover:underline">[공지] 커뮤니티 규칙 변경 안내</a></li>
        <li><a href="#" class="text-blue-600 hover:underline">[이벤트] 출석체크 이벤트 시작!</a></li>
      </ul>
    </div>
  </div>  
  
    <div id="editInfo" class="content-section hidden">
        <h2 class="text-xl font-semibold mb-4">내 정보 수정</h2>
        <form action="/member/updateInfo" method="post" class="space-y-4 max-w-md">
            <div>
            <label for="nickname" class="block mb-1 font-medium">닉네임</label>
            <input type="text" id="nickname" name="nickname" required
                    class="w-full px-4 py-2 border border-gray-300 rounded focus:outline-none focus:ring focus:border-blue-400">
            </div>

            <div>
            <label for="team" class="block mb-1 font-medium">응원 팀 (KBO)</label>
            <select id="team" name="team" required
                    class="w-full px-4 py-2 border border-gray-300 rounded focus:outline-none focus:ring focus:border-blue-400">
                <option value="">-- 선택하세요 --</option>
                <option value="KIA">KIA 타이거즈</option>
                <option value="LG">LG 트윈스</option>
                <option value="롯데">롯데 자이언츠</option>
                <option value="두산">두산 베어스</option>
                <option value="SSG">SSG 랜더스</option>
                <option value="NC">NC 다이노스</option>
                <option value="한화">한화 이글스</option>
                <option value="삼성">삼성 라이온즈</option>
                <option value="KT">KT 위즈</option>
                <option value="키움">키움 히어로즈</option>
            </select>
            </div>

            <div>
            <label for="mlbTeam" class="block mb-1 font-medium">응원 팀 (MLB)</label>
            <select id="mlbTeam" name="mlbTeam"
                    class="w-full px-4 py-2 border border-gray-300 rounded focus:outline-none focus:ring focus:border-blue-400">
                <option value="">-- 선택하세요 --</option>
                <option value="NYY">New York Yankees</option>
                <option value="LAD">LA Dodgers</option>
                <option value="BOS">Boston Red Sox</option>
                <option value="CHC">Chicago Cubs</option>
                <option value="SF">San Francisco Giants</option>
                <option value="TOR">Toronto Blue Jays</option>
                <option value="ATL">Atlanta Braves</option>
                <option value="HOU">Houston Astros</option>
                <option value="SEA">Seattle Mariners</option>
                <option value="NYM">New York Mets</option>
            </select>
            </div>

            <div class="pt-2">
            <button type="submit"
                    class="px-6 py-2 bg-blue-600 text-white rounded hover:bg-blue-500">정보 수정</button>
            </div>
        </form>
    </div>

    <div id="changePw" class="content-section hidden">비밀번호 변경</div>
    <div id="myPosts" class="content-section hidden">내가 쓴 글 목록</div>
    <div id="myComments" class="content-section hidden">내가 쓴 댓글 목록</div>
    <div id="myLikes" class="content-section hidden">좋아요 누른 글</div>
    <div id="pointHistory" class="content-section hidden">
        <h2 class="text-xl font-semibold mb-4">포인트 내역</h2>

        <!-- 레벨업 바 -->
        <div class="w-full bg-gray-200 rounded-full h-5 mb-4">
            <div class="bg-blue-500 h-5 rounded-full" style="width: 62%;"></div>
        </div>
        <p class="text-sm text-gray-600 mb-4">다음 등급까지 380 포인트 남았습니다.</p>

        <!-- 포인트 내역 보기 버튼 -->
        <button onclick="document.getElementById('pointTable').classList.toggle('hidden')"
                class="mb-4 px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-500">
            포인트 내역 보기
        </button>

        <!-- 포인트 내역 테이블 (초기 숨김 처리) -->
        <div id="pointTable" class="hidden">
            <table class="w-full text-left border border-gray-200">
            <thead class="bg-gray-100">
                <tr>
                <th class="p-2 border">날짜</th>
                <th class="p-2 border">내용</th>
                <th class="p-2 border">변동</th>
                <th class="p-2 border">누적</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                <td class="p-2 border">2025-06-26</td>
                <td class="p-2 border">출석체크</td>
                <td class="p-2 border text-green-600">+10</td>
                <td class="p-2 border">1,240</td>
                </tr>
                <tr>
                <td class="p-2 border">2025-06-25</td>
                <td class="p-2 border">게시글 작성</td>
                <td class="p-2 border text-green-600">+20</td>
                <td class="p-2 border">1,230</td>
                </tr>
            </tbody>
            </table>
        </div>
    </div>

    <!-- 등급 기준 보기 -->
    <div id="levelInfo" class="content-section hidden">
        <h2 class="text-xl font-semibold mb-4">등급 기준</h2>
        <table class="w-full text-left border border-gray-200">
            <thead class="bg-gray-100">
            <tr>
                <th class="p-2 border">등급</th>
                <th class="p-2 border">필요 포인트</th>
                <th class="p-2 border">설명</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td class="p-2 border">루키</td>
                <td class="p-2 border">0 ~ 499</td>
                <td class="p-2 border">가입 후 기본 등급</td>
            </tr>
            <tr>
                <td class="p-2 border">멤버</td>
                <td class="p-2 border">500 ~ 999</td>
                <td class="p-2 border">활동을 시작한 유저</td>
            </tr>
            <tr>
                <td class="p-2 border">프로</td>
                <td class="p-2 border">1000 ~ 1999</td>
                <td class="p-2 border">기여도가 높은 유저</td>
            </tr>
            <tr>
                <td class="p-2 border">레전드</td>
                <td class="p-2 border">2000+</td>
                <td class="p-2 border">최상위 유저</td>
            </tr>
            </tbody>
        </table>
    </div>
    <div id="alarmSetting" class="content-section hidden">알림 설정</div>
    <div id="darkMode" class="content-section hidden">
        <button onclick="toggleDarkMode()" class="mt-4 px-4 py-2 bg-gray-800 text-white rounded hover:bg-gray-700">
            다크모드 전환
        </button>
    </div>
    <div id="withdraw" class="content-section hidden">
        <h2 class="text-xl font-semibold mb-4 text-red-600">회원 탈퇴</h2>

        <div class="mb-4 p-4 bg-gray-100 border rounded text-sm">
            <p class="mb-2 font-semibold">[탈퇴 약관]</p>
            <p>회원 탈퇴 시 작성한 게시글, 댓글 등은 삭제되지 않으며, 복구가 불가능합니다.<br>
            포인트 및 등급 정보 또한 복원되지 않으니 신중히 결정해주세요.</p>
        </div>

        <form id="withdrawForm" action="/member/withdraw" method="post" class="space-y-4 max-w-md">
            <div>
            <label class="inline-flex items-center">
                <input type="checkbox" id="agree" class="form-checkbox text-red-600 mr-2">
                <span class="text-sm">탈퇴 약관을 모두 읽었으며 이에 동의합니다.</span>
            </label>
            </div>

            <div>
            <label for="currentPassword" class="block mb-1 font-medium">현재 비밀번호 입력</label>
            <input type="password" id="currentPassword" name="currentPassword" required
                    class="w-full px-4 py-2 border border-gray-300 rounded focus:outline-none focus:ring focus:border-red-400">
            </div>

            <div>
            <button type="submit" id="withdrawBtn" disabled
                    class="px-6 py-2 bg-red-500 text-white rounded opacity-50 cursor-not-allowed">
                회원 탈퇴
            </button>
            </div>
        </form>
    </div>

  </section>
</main>

</body>
</html>