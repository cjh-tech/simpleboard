package com.simpleboard.vo;

import java.io.UnsupportedEncodingException; 
import java.net.URLEncoder;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

public class PageMaker {
	
	private int totalCount;
	private int startPage;
	private int endPage;
	private boolean prev;
	private boolean next;
	private int displayPageNum = 10;
	
	private Criteria cri; //기준점 파일
	
	public void setCri(Criteria cri) {
		this.cri = cri; //cri 클래스 받음
	}
	
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount; // 전체 글숫자 
		calcData(); // 계산 
	}
	
	public int getTotalCount() {
		return totalCount;
	}
	
	public int getStartPage() {
		return startPage;
	}
	
	public int getEndPage() {
		return endPage;
	}
	
	public boolean isPrev() {
		return prev;
	}
	
	public boolean isNext() {
		return next;
	}
	
	public int getDisplayPageNum() {
		return displayPageNum;
	}
	
	public Criteria getCri() {
		return cri;
	}
		
	private void calcData() {
		endPage = (int) (Math.ceil(cri.getPage() / (double)displayPageNum) * displayPageNum); 
		//끝나는 페이지  Math.ceil 올림 함수//  (criteria 파일의 getPage() 값을 displayPageNum으로 나눔) 곱하기 디스플레이페이지번호  
		
		startPage = (endPage - displayPageNum) + 1; // 시작페이지 -> 끝나는 페이지 - 보여주는 페이지  +1
													//             
		int tempEndPage = (int) (Math.ceil(totalCount / (double)cri.getPerPageNum()));
		if (endPage > tempEndPage) {
			endPage = tempEndPage;
		}
		prev = startPage == 1 ? false : true;
		next = endPage * cri.getPerPageNum() >= totalCount ? false : true;
	}
	
	public String makeQuery(int page) {  //uri 만들어주기 검색부분 없이 
		UriComponents uriComponents =
		UriComponentsBuilder.newInstance()
						    .queryParam("page", page)
							.queryParam("perPageNum", cri.getPerPageNum())
							.build();
		   
		return uriComponents.toUriString();
	}
	
	public String makeSearch(int page)
	{ //검색uri 쿼리 만들기 ( 화면단에서 내용 , 제목, 내용+제목 관련 ) 
	  //UriCOmponentsBuilder 여러개의 파라미터를 연결해서 하나의 URL을 제공 
	 UriComponents uriComponents =
	            UriComponentsBuilder.newInstance()
	            .queryParam("page", page) // ?page=page값
	            .queryParam("perPageNum", cri.getPerPageNum()) //perPageNum=cri.getPerPageNum()값
	            .queryParam("searchType", ((SearchCriteria)cri).getSearchType()) // searchType=((SearchCriteria)cri).getSearchType()값
	            .queryParam("keyword", encoding(((SearchCriteria)cri).getKeyword()))// keyword=encoding(((SearchCriteria)cri).getKeyword())값
	            .build();  // 생성
	    return uriComponents.toUriString();   //.toUriString()으로 값 출력해서 리턴
	}

	private String encoding(String keyword) { //인코딩
		if(keyword == null || keyword.trim().length() == 0) { 
			return "";
		}
		 
		try {
			return URLEncoder.encode(keyword, "UTF-8");
		} catch(UnsupportedEncodingException e) { 
			return ""; 
		}
	}
}