package com.simpleboard.vo;

public class Criteria {
	
	private int page; //페이지 변수 선언
	private int perPageNum; // 페이지당 번호 선언
	private int rowStart; // 행시작
	private int rowEnd; // 행끝 
	
	public Criteria() {
		this.page = 1;  // 기준 페이지를 1로
		this.perPageNum = 10; // 페이지당 10개씩 
	}
	
	public void setPage(int page) {
		if (page <= 0) {
			this.page = 1;
			return;
		}
		this.page = page;
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
		rowStart = ((page - 1) * perPageNum) + 1; //행시작번호 = 페이지 -1 곱하기 개당페이지 +1 
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
