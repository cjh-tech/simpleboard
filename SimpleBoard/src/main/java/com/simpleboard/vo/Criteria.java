package com.simpleboard.vo;

public class Criteria {
	// 건드리면 안되는 기준점 페이징처리시에
	private int page; //현재 페이지 번호
	private int perPageNum; // 페이지당 보여줄 게시글수
	private int rowStart; // 행시작  어느 페이지버튼을 누를시에 페이지버튼의 시작번호   1 2 3 4 5 6 7 8 9 10 중 뭐하나 누르면  나오는 시작번호 1번을 의미
	private int rowEnd; // 행끝  어느 페이지버튼을 누를시에 페이지버튼의 끝번호        1 2 3 4 5 6 7 8 9 10 중 뭐하나 누르면 나오는 끝번호 10을 의미
	
	public Criteria() { //생성자  -> 변수 초기화
		this.page = 1;  // 초기 기준 페이지를 1로
		this.perPageNum = 10; // 한 버튼당 10개씩 글목록 보여줌  
	}
	
	public int getPage() {
		return page; 
	}
		
	public void setPage(int page) {
		if (page <= 0) { // 페이지 0이하면 1넣어줌 최소한의 페이지 유지  
			this.page = 1;
			return;
		}
		this.page = page; // 페이지에 페이지를 넣음
	}
	
	public int getPerPageNum() {
		return this.perPageNum;
	}
	
	public void setPerPageNum(int perPageNum) {
		if (perPageNum <= 0 || perPageNum > 100) { // 개당 페이지 0보다 작거나 100보다 크면 
			this.perPageNum = 10; // 페이지당 보여줄 게시글 10개로
			return;
		}
		this.perPageNum = perPageNum; 
	}
	
		
	public int getPageStart() {
		return (this.page - 1) * perPageNum; //  현재 페이지버튼의 게시글 행의 시작 번호(게시글임 게시글)
	}
	
	public int getRowStart() {
		System.out.println("getPageStart.........."+getPageStart());
		rowStart = ((page - 1) * perPageNum) + 1; //어느 페이지버튼을 누를시에 페이지버튼의 시작번호 = ((페이지 -1) x 개당페이지) +1 
		System.out.println("rowStart..........."+rowStart);
		return rowStart;
	}
	
	public int getRowEnd() {
		rowEnd = rowStart + perPageNum - 1;  // 어느 페이지버튼을 누를시에 페이지버튼의 마지막번호
		System.out.println("rowEnd..........."+rowEnd);
		return rowEnd;
	}

	
	
	
	// 클래스의 값이 잘 담겨져 있는지 toString() 메서드를 오버라이드하여 확인할수 있음
	@Override
	public String toString() {
		return "Criteria [page=" + page + ", perPageNum=" + perPageNum + ", rowStart=" + rowStart + ", rowEnd=" + rowEnd
				+ "]";
	}
	

}
