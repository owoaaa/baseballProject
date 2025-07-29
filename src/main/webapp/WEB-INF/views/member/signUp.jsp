<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>회원가입 - Baseball Community</title>
  <link rel="stylesheet" href="/resources/css/style.css">
  <script src="https://cdn.tailwindcss.com"></script>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

  <script>
    let isIdChecked = false;
    let isNickChecked = false;

    function validateId(id) {
      return /^[a-zA-Z0-9]{1,10}$/.test(id);
    }

    function validateNick(nick) {
      return /^[가-힣a-zA-Z0-9]{1,10}$/.test(nick);
    }

    function checkId() {
      const memberId = document.querySelector("input[name='memberId']").value;

      if (!validateId(memberId)) {
        alert("아이디는 영어+숫자 조합, 10자 이하만 가능합니다.");
        return;
      }

      $.ajax({
        url: "/member/checkId",
        method: "GET",
        data: { memberId },
        success: function(result) {
          if (result === "0") {
            alert("사용 가능한 아이디입니다.");
            isIdChecked = true;
          } else {
            alert("이미 사용 중인 아이디입니다.");
            isIdChecked = false;
          }
        },
        error: function() {
          alert("중복 검사 실패");
        }
      });
    }

    function checkNick() {
      const memberNick = document.querySelector("input[name='memberNick']").value;

      if (!validateNick(memberNick)) {
        alert("닉네임은 특수문자를 제외한 10자 이하만 가능합니다.");
        return;
      }

      $.ajax({
        url: "/member/checkNick",
        method: "GET",
        data: { memberNick },
        success: function(result) {
          if (result === "0") {
            alert("사용 가능한 닉네임입니다.");
            isNickChecked = true;
          } else {
            alert("이미 사용 중인 닉네임입니다.");
            isNickChecked = false;
          }
        },
        error: function() {
          alert("중복 검사 실패");
        }
      });
    }

    function validateForm() {
      const id = document.querySelector("input[name='memberId']").value;
      const pw = document.querySelector("input[name='memberPw']").value;
      const pw2 = document.querySelector("input[name='pwConfirm']").value;
      const nick = document.querySelector("input[name='memberNick']").value;

      if (!validateId(id)) {
        alert("아이디는 영어+숫자 조합, 10자 이하만 가능합니다.");
        return false;
      }

      if (!validateNick(nick)) {
        alert("닉네임은 특수문자를 제외한 10자 이하만 가능합니다.");
        return false;
      }

      if (!isIdChecked) {
        alert("아이디 중복확인을 해주세요.");
        return false;
      }

      if (!isNickChecked) {
        alert("닉네임 중복확인을 해주세요.");
        return false;
      }

      if (pw.length < 4) {
        alert("비밀번호는 4자 이상이어야 합니다.");
        return false;
      }

      if (pw !== pw2) {
        alert("비밀번호가 일치하지 않습니다.");
        return false;
      }

      return true;
    }
  </script>
</head>

<body class="bg-white text-gray-800">

  <!-- 상단 네비게이션 -->
  <jsp:include page="/WEB-INF/views/common/header.jsp" />

  <!-- 회원가입 폼 -->
  <main class="max-w-xl mx-auto px-4 py-12">
    <h2 class="text-2xl font-bold mb-6 text-center">회원가입</h2>

    <form action="/member/signUp" method="post" class="space-y-4" onsubmit="return validateForm()">

      <!-- 아이디 입력 + 중복확인 -->
      <label class="block mb-1 text-gray-700 font-medium">아이디</label>
      <div class="flex gap-2">
        <input type="text" name="memberId" placeholder="아이디" required class="w-full px-4 py-2 border rounded-md">
        <button type="button" onclick="checkId()" class="w-24 py-2 bg-gray-300 rounded-md">중복확인</button>
      </div>

      <!-- 비밀번호 -->
      <label class="block mb-1 text-gray-700 font-medium">비밀번호</label>
      <input type="password" name="memberPw" placeholder="비밀번호" required class="w-full px-4 py-2 border rounded-md">

      <!-- 비밀번호 확인 -->
      <label class="block mb-1 text-gray-700 font-medium">비밀번호 확인</label>
      <input type="password" name="pwConfirm" placeholder="비밀번호 확인" required class="w-full px-4 py-2 border rounded-md">

      <!-- 닉네임 + 중복확인 -->
      <label class="block mb-1 text-gray-700 font-medium">닉네임</label>
      <div class="flex gap-2">
        <input type="text" name="memberNick" placeholder="닉네임" required class="w-full px-4 py-2 border rounded-md">
        <button type="button" onclick="checkNick()" class="w-24 py-2 bg-gray-300 rounded-md">중복확인</button>
      </div>

      <!-- KBO 팀 선택 -->
      <div>
        <label class="block mb-1 text-gray-700 font-medium">선호 KBO 팀 (선택)</label>
        <select name="kboTeamNo" class="w-full px-4 py-2 border rounded-md">
          <option value="">선택 안함</option>
          <c:forEach var="team" items="${kboTeamList}">
            <option value="${team.teamNo}">${team.teamName}</option>
          </c:forEach>
        </select>
      </div>

      <!-- MLB 팀 선택 -->
      <div>
        <label class="block mb-1 text-gray-700 font-medium">선호 MLB 팀 (선택)</label>
        <select name="mlbTeamNo" class="w-full px-4 py-2 border rounded-md">
          <option value="">선택 안함</option>
          <c:forEach var="team" items="${mlbTeamList}">
            <option value="${team.teamNo}">${team.teamName}</option>
          </c:forEach>
        </select>
      </div>

      <!-- 제출 -->
      <div>
        <button type="submit" class="w-full bg-blue-600 text-white py-2 rounded-md hover:bg-blue-700 mt-20">회원가입</button>
      </div>

    </form>
  </main>

  <!-- 푸터 -->
  <jsp:include page="/WEB-INF/views/common/footer.jsp" />
  <script src="/resources/js/darkMode.js"></script>
</body>
</html>