<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>마이페이지</title>
    <link rel="stylesheet" href="/resources/css/style.css">
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

        // 주의: 여기 있던 toggleDarkMode() 함수는 삭제했습니다.
        // 이 기능은 이제 /resources/js/darkMode.js 에서 전역적으로 관리됩니다.

        // 회원 탈퇴
        document.addEventListener('DOMContentLoaded', function () {
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

            if (agreeCheckbox && passwordInput) {
                agreeCheckbox.addEventListener('change', checkWithdrawConditions);
                passwordInput.addEventListener('input', checkWithdrawConditions);
            }
        });

        /* 내가 쓴 글 댓글 ajax */
        // 게시글 목록 로딩
        function loadMyPosts(page) {
            fetch(`/member/myPosts?page=${page}`)
                .then(res => res.text())
                .then(html => {
                    document.getElementById('myPosts').innerHTML = html;
                })
                .catch(err => {
                    console.error('게시글 불러오기 실패:', err);
                    document.getElementById('myPosts').innerHTML =
                        '<p class="text-red-500">게시글 불러오기 실패</p>';
                });
        }

        // 댓글 목록 로딩
        function loadMyReplies(page) {
            fetch(`/member/myReplies?page=${page}`)
                .then(res => res.text())
                .then(html => {
                    document.getElementById('myComments').innerHTML = html;
                })
                .catch(err => {
                    console.error('댓글 불러오기 실패:', err);
                    document.getElementById('myComments').innerHTML =
                        '<p class="text-red-500">댓글 불러오기 실패</p>';
                });
        }

        // 페이지 진입 시 기본으로 게시글 1페이지 로딩
        document.addEventListener('DOMContentLoaded', () => {
            loadMyPosts(1);
            loadMyReplies(1);
        });
    </script>
    </head>
<body class="bg-gray-50 text-gray-800">

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<main class="max-w-7xl mx-auto mt-8 flex">
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
                    </ul>
            </li>

            <li>
                <button onclick="toggleMenu('menu-etc')" class="flex items-center gap-3 w-full text-left px-4 py-2 bg-white rounded-lg shadow-sm hover:bg-red-50 transition">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-red-500" fill="none"
                        viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                        <path stroke-linecap="round" stroke-linejoin="round"
                                d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1H9a1 1 0 00-1 1v3m12 0H4" />
                    </svg>
                    <span class="text-red-600 font-medium">회원 탈퇴</span>
                </button>
                <ul id="menu-etc" class="ml-8 mt-2 space-y-1 hidden">
                    <li><button onclick="showContent('withdraw')" class="text-red-600 hover:text-red-700 block">- 회원 탈퇴</button></li>
                </ul>
            </li>
        </ul>
    </aside>

    <section class="w-3/4 bg-white p-6 rounded shadow-sm space-y-6">
        <div id="home" class="content-section space-y-6">
            <h2 class="text-2xl font-semibold">마이페이지</h2>
            <div class="bg-white p-4 rounded shadow-sm border border-gray-200">
                <h3 class="text-lg font-semibold mb-2">공지 및 알림</h3>
                <ul class="text-sm text-gray-700 space-y-1">
                    <li><a href="#" class="text-blue-600 hover:underline">[공지] 커뮤니티 규칙 변경 안내</a></li>
                    <li><a href="#" class="text-blue-600 hover:underline">[이벤트] 출석체크 이벤트 시작!</a></li>
                </ul>
            </div>

            <div class="bg-gray-100 p-4 rounded shadow-sm">
                <h3 class="text-lg font-semibold mb-2">회원 정보</h3>
                <ul class="space-y-1 text-sm">
                    <li><strong>닉네임:</strong> <span class="text-gray-700">${loginMember.memberNick}</span></li>
                    <li><strong>가입일:</strong> <span class="text-gray-700"><fmt:formatDate value="${loginMember.enrollDate}" pattern="yyyy년 M월 d일 HH:mm:ss" /></span></li>
                    <li><strong>KBO 응원팀:</strong>
                        <span class="text-gray-700">
                            <c:forEach var="team" items="${kboTeamList}">
                                <c:if test="${team.teamNo == loginMember.kboTeamNo}">
                                    ${team.teamName}
                                </c:if>
                            </c:forEach>
                        </span>
                    </li>

                    <li><strong>MLB 응원팀:</strong>
                        <span class="text-gray-700">
                            <c:forEach var="team" items="${mlbTeamList}">
                                <c:if test="${team.teamNo == loginMember.mlbTeamNo}">
                                    ${team.teamName}
                                </c:if>
                            </c:forEach>
                        </span>
                    </li>
                </ul>
            </div>

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

            <div class="bg-gray-50 p-4 rounded shadow-sm">
                <h3 class="text-lg font-semibold mb-2">최근 활동</h3>

                <c:if test="${empty recentBoards and empty recentReplies}">
                    <div class="text-sm text-gray-400">최근 작성한 게시글 또는 댓글이 없습니다.</div>
                </c:if>

                <div class="space-y-2">
                    <c:forEach var="board" items="${recentBoards}">
                        <div class="p-2 bg-blue-50 border-l-4 border-blue-500 rounded text-sm">
                            <fmt:formatDate value="${board.createDate}" pattern="yyyy-MM-dd" />
                            <strong class="ml-1 text-blue-700">[게시글]</strong>
                            <span class="font-semibold">"${board.boardTitle}"</span>
                        </div>
                    </c:forEach>

                    <c:forEach var="reply" items="${recentReplies}">
                        <div class="p-2 bg-green-50 border-l-4 border-green-500 rounded text-sm">
                            <fmt:formatDate value="${reply.replyCreateDate}" pattern="yyyy-MM-dd" />
                            <strong class="ml-1 text-green-700">[댓글]</strong>
                            <span class="font-semibold">"${reply.replyContent}"</span>
                            <span class="ml-1 text-gray-600">(
                                <a href="/board/detail?no=${reply.board.boardNo}" class="text-blue-600 underline">
                                    ${reply.board.boardTitle}
                                </a>)
                            </span>
                        </div>
                    </c:forEach>
                </div>
            </div>

        </div> 
        
        <div id="editInfo" class="content-section hidden">
            <h2 class="text-xl font-semibold mb-4">내 정보 수정</h2>
            <form action="/member/updateInfo" method="post" class="space-y-4 max-w-md">
                
                <div>
                    <label for="memberNick" class="block mb-1 font-medium">닉네임</label>
                    <input type="text" id="memberNick" name="memberNick" required
                            value="${loginMember.memberNick}"
                            class="w-full px-4 py-2 border border-gray-300 rounded focus:outline-none focus:ring focus:border-blue-400">
                </div>

                <div>
                    <label for="team" class="block mb-1 font-medium">응원 팀 (KBO)</label>
                    <select id="team" name="kboTeamNo" required
                                class="w-full px-4 py-2 border border-gray-300 rounded">
                        <option value="">-- 선택하세요 --</option>
                        <c:forEach var="team" items="${kboTeamList}">
                            <c:choose>
                                <c:when test="${loginMember.kboTeamNo == team.teamNo}">
                                    <option value="${team.teamNo}" selected>${team.teamName}</option>
                                </c:when>
                                <c:otherwise>
                                    <option value="${team.teamNo}">${team.teamName}</option>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </select>
                </div>

                <div>
                    <label for="mlbTeam" class="block mb-1 font-medium">응원 팀 (MLB)</label>
                    <select id="mlbTeam" name="mlbTeamNo"
                                class="w-full px-4 py-2 border border-gray-300 rounded">
                        <option value="">-- 선택하세요 --</option>
                        <c:forEach var="team" items="${mlbTeamList}">
                            <c:choose>
                                <c:when test="${loginMember.mlbTeamNo == team.teamNo}">
                                    <option value="${team.teamNo}" selected>${team.teamName}</option>
                                </c:when>
                                <c:otherwise>
                                    <option value="${team.teamNo}">${team.teamName}</option>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </select>
                </div>

                <div class="pt-2">
                    <button type="submit"
                                class="px-6 py-2 bg-blue-600 text-white rounded hover:bg-blue-500">정보 수정</button>
                </div>

            </form>
        </div>

        <div id="changePw" class="content-section hidden">비밀번호 변경</div>
        <div id="myPosts" class="content-section hidden">
            <h3 class="text-lg font-semibold mb-3">내가 쓴 글</h3>
            <div id="postTableContainer">
                </div>
        </div>

        <div id="myComments" class="content-section hidden">
            <h3 class="text-lg font-semibold mb-3">내가 쓴 댓글</h3>
            <div id="commentTableContainer">
                </div>
        </div>
        <div id="myLikes" class="content-section hidden">좋아요 누른 글</div>
        <div id="pointHistory" class="content-section hidden">
            <h2 class="text-xl font-semibold mb-4">포인트 내역</h2>

            <div class="w-full bg-gray-200 rounded-full h-5 mb-4">
                <div class="bg-blue-500 h-5 rounded-full" style="width: 62%;"></div>
            </div>
            <p class="text-sm text-gray-600 mb-4">다음 등급까지 380 포인트 남았습니다.</p>

            <button onclick="document.getElementById('pointTable').classList.toggle('hidden')"
                        class="mb-4 px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-500">
                포인트 내역 보기
            </button>

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

<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<script src="/resources/js/darkMode.js"></script>

</body>
</html>