package com.simpleboard.vo;

public class SearchCriteria extends Criteria{
    // Criteria를 부모클래스로 하여 그 내부의 값들 전부 사용가능
	private String searchType = "";
	private String keyword = "";
	 
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	@Override  // toString을 오버라이드 해서 객체의 내용을 보기위함 
	public String toString() {
		return "SearchCriteria [searchType=" + searchType + ", keyword=" + keyword + "]";
	}
	
}
