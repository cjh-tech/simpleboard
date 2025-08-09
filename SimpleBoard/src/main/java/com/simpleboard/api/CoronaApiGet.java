package com.simpleboard.api;

import java.util.LinkedList;
import java.util.List;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

public class CoronaApiGet {
	
	public List getdeath() throws Exception {
		//xml방식
		//현재 시간날짜 가져오기
		java.util.Calendar cal = java.util.Calendar.getInstance();
		java.text.DateFormat format = new java.text.SimpleDateFormat("yyyyMMdd");
		
		String dateStr = format.format(cal.getTime());
		
		String url ="http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19InfStateJson?serviceKey=2jQ5%2FYDyIg42pcwQJCaa68fUwsvdoPBSuZ%2BudGJ3idpPmlVcJ8YHAkXCGQMmZNaDr%2F1eIfbzkJqXRCXc2HFLkg%3D%3D&pageNo=1&numOfRows=10&startCreateDt=20200310&endCreateDt="+dateStr;
		
		// 1. 문서를 읽기위한 빌더팩토리를 만들어야 한다.
		DocumentBuilderFactory builderFactory = DocumentBuilderFactory.newInstance();
		
		// 2. 빌더 생성
		DocumentBuilder Builder = builderFactory.newDocumentBuilder();
		
		// 3. url xml 파싱 
		Document doc = Builder.parse(url);
		
		// 4. 문서 구조 안정화 
		doc.getDocumentElement().normalize();
				
		// 5. 최상위 태그 접근 
		Element root = doc.getDocumentElement(); 
		
		NodeList nodeList = root.getElementsByTagName("item");
		
		//	리스트 선언
		List<String> listdata = new LinkedList<String>();
		for(int i = 0; i < 7; i++) {
			Node node = nodeList.item(i);
			// node item 요소의 i번째	 		
			Element personElement = (Element) node;
			// node를 element화 		
			
			NodeList nameList = personElement.getElementsByTagName("deathCnt");
			// i번째 item태그에서의 deathCnt를 다시 nodeList화
			
			Element deathcnt = (Element)nameList.item(0);
			// 위에서 nameList 값의 첫번째 를 element화
			
			Node name = deathcnt.getFirstChild();
			// deathcnt의 첫번째자식값(데이터값) node로 변환 
		
			listdata.add(i, name.getNodeValue());
						
		}
		return listdata;
	}
	
	public List getdate() throws Exception {
		
		//현재 시간날짜 가져오기
		java.util.Calendar cal = java.util.Calendar.getInstance();
		java.text.DateFormat format = new java.text.SimpleDateFormat("yyyyMMdd");
		
		String dateStr = format.format(cal.getTime());
		
		String url ="http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19InfStateJson?serviceKey=2jQ5%2FYDyIg42pcwQJCaa68fUwsvdoPBSuZ%2BudGJ3idpPmlVcJ8YHAkXCGQMmZNaDr%2F1eIfbzkJqXRCXc2HFLkg%3D%3D&pageNo=1&numOfRows=10&startCreateDt=20200310&endCreateDt="+dateStr;
		// 1. 문서를 읽기위한 빌더팩토리를 만들어야 한다.
		DocumentBuilderFactory builderFactory = DocumentBuilderFactory.newInstance();
		
		// 2. 빌더 생성
		DocumentBuilder Builder = builderFactory.newDocumentBuilder();
		
		// 3. url xml 파싱 
		Document doc = Builder.parse(url);
		
		// 4. 문서 구조 안정화 
		doc.getDocumentElement().normalize();
				
		// 5. 최상위 태그 접근 
		Element root = doc.getDocumentElement(); 
		
		NodeList nodeList = root.getElementsByTagName("item");
		
		//	리스트 선언
		List<String> listdata = new LinkedList<String>();
		for(int i = 0; i < 7; i++) {
			Node node = nodeList.item(i);
			// node item 요소의 i번째	 		
			Element personElement = (Element) node;
			// node를 element화 		
			
			NodeList nameList = personElement.getElementsByTagName("stateDt");
			// i번째 item태그에서의 deathCnt를 다시 nodeList화
			
			Element deathcnt = (Element)nameList.item(0);
			// 위에서 nameList 값의 첫번째 를 element화
			
			Node name = deathcnt.getFirstChild();
			// deathcnt의 첫번째자식값(데이터값) node로 변환 
		
			listdata.add(i, name.getNodeValue());
						
		}
		return listdata;
	}
	
		


}
