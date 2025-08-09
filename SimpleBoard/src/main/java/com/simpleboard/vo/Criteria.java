package com.simpleboard.vo;

public class Criteria {
	// 건드리면 안되는 기준점 페이징처리시에
	private int page; //페이지 변수 선언
	private int perPageNum; // 페이지당 번호 선언
	private int rowStart; // 행시작
	private int rowEnd; // 행끝 
	
	public Criteria() { //생성자  -> 변수 초기화
		this.page = 1;  // 기준 페이지를 1로
		this.perPageNum = 10; // 한 버튼 페이지당 10개씩 글목록 보여줌  
	}
	
	public void setPage(int page) {
		if (page <= 0) { // 페이지 변수가 0이하면 1넣어줌 최소한의 페이지 유지  
			this.page = 1;
			return;
		}
		this.page = page; // 페이지에 페이지를 넣음
	}
	
	public void setPerPageNum(int perPageNum) {
		if (perPageNum <= 0 || perPageNum > 100) { // 개당 페이지 0이보다 작거나 100보다 크면 
			this.perPageNum = 10; // 개당페이지를 10개로
			return;
		}
		this.perPageNum = perPageNum; 
	}
	
	public int getPage() {
		return page; 
	}
	
	public int getPageStart() {
		return (this.page - 1) * perPageNum; // 시작페이지를 첫번째 페이지 -1 곱하기 개당페이지 
	}
	
	public int getPerPageNum() {
		return this.perPageNum;
	}
	
	public int getRowStart() {
		rowStart = ((page - 1) * perPageNum) + 1; //행시작번호 = ((페이지 -1) x 개당페이지) +1 
		return rowStart;
	}
	
	public int getRowEnd() {
		rowEnd = rowStart + perPageNum - 1; 
		return rowEnd;
	}

	// 클래스의 값이 잘 담겨져 있는지 toString() 메서드를 오버라이드하여 확인할수 있음
	@Override
	public String toString() {
		return "Criteria [page=" + page + ", perPageNum=" + perPageNum + ", rowStart=" + rowStart + ", rowEnd=" + rowEnd
				+ "]";
	}
	

}
