package kr.swj.baseball.board.model.dto;


import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PageInfo {
    private int listCount;      // 총 게시글 수
    private int currentPage;    // 현재 페이지 번호
    private int pageLimit;      // 하단에 보여줄 페이지 수
    private int boardLimit;     // 한 페이지당 게시글 수
    private int maxPage;        // 총 페이지 수
    private int startPage;      // 페이지 하단 시작 번호
    private int endPage;        // 페이지 하단 끝 번호
    private int startRow;       // SQL 시작행 번호
    private int endRow;         // SQL 끝행 번호

    public PageInfo(int listCount, int currentPage, int pageLimit, int boardLimit) {
        this.listCount = listCount;
        this.currentPage = currentPage;
        this.pageLimit = pageLimit;
        this.boardLimit = boardLimit;

        this.maxPage = (int)Math.ceil((double)listCount / boardLimit);
        this.startPage = ((currentPage - 1) / pageLimit) * pageLimit + 1;
        this.endPage = startPage + pageLimit - 1;
        if(endPage > maxPage) endPage = maxPage;

        this.startRow = (currentPage - 1) * boardLimit + 1;
        this.endRow = startRow + boardLimit - 1;
    }

}