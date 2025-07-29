// 다크 모드 토글 버튼 요소 가져오기
const darkModeToggle = document.getElementById('darkModeToggle');
const sunIcon = document.getElementById('sunIcon');
const moonIcon = document.getElementById('moonIcon');

// 페이지 로드 시 다크 모드 상태 확인 및 적용
function applyTheme() {
    const currentTheme = localStorage.getItem('theme') || 'light';

    if (currentTheme === 'dark') {
        document.documentElement.classList.add('dark-mode'); // HTML 요소에 'dark-mode' 클래스 추가

        // --- 이 부분을 수정합니다 ---
        // 현재 다크 모드일 때 '해' 아이콘을 보여주고 싶다면
        sunIcon.classList.remove('hidden');   // 해 아이콘 보이기
        moonIcon.classList.add('hidden');     // 달 아이콘 숨기기
        // --------------------------

    } else { // light 모드일 때
        document.documentElement.classList.remove('dark-mode'); // 'dark-mode' 클래스 제거
        
        // --- 이 부분을 수정합니다 ---
        // 현재 라이트 모드일 때 '달' 아이콘을 보여주고 싶다면
        sunIcon.classList.add('hidden');      // 해 아이콘 숨기기
        moonIcon.classList.remove('hidden');  // 달 아이콘 보이기
        // --------------------------
    }
}

// 초기 로드 시 테마 적용
applyTheme();

// 다크 모드 토글 버튼 클릭 이벤트 리스너
if (darkModeToggle) { // 버튼이 존재할 경우에만 이벤트 리스너 추가
    darkModeToggle.addEventListener('click', () => {
        let currentTheme = localStorage.getItem('theme');

        if (currentTheme === 'dark') {
            localStorage.setItem('theme', 'light');
        } else {
            localStorage.setItem('theme', 'dark');
        }
        
        applyTheme(); // 테마 변경 후 다시 적용 함수 호출
    });
}