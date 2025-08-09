package com.simpleboard.vo;

import java.util.Date;
     // vo파일은 DB와의 칼럼명들과 속성을 담아놓은 파일이라고 보면 될듯 
     // vo?   Value Object	값 객체 
	 // dto?  Data Transfer Object 데이터 전송 객체	
	 // dto는 값을 전달하는 것이 주 목적 getter setter 사용가능
     // vo는 값을 표현하는 것이 목적 getter만 사용가능 그외 로직 가능 (현재 이 파일은 VO라고 되어있지만 setter를 사용하고 있는 실수를 범하고 있다 )
public class BoardVO {
	private int bno;
	private String title;
	private String content;
	private String writer;
	private Date regdate;
	
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	
}
