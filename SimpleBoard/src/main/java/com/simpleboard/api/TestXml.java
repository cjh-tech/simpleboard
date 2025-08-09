package com.simpleboard.api;

import java.util.Calendar;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

public class TestXml {
	
	public static void main(String[] args) throws Exception{

		Calendar today = Calendar.getInstance();
		// 지난해 연도가 기준점이 됨
		int year = Integer.valueOf(today.get((Calendar.YEAR))-1).intValue();
		
		String url = "http://apis.data.go.kr/1741000/HeatWaveCasualtiesRegion/getHeatWaveCasualtiesRegionList?ServiceKey=2jQ5%2FYDyIg42pcwQJCaa68fUwsvdoPBSuZ%2BudGJ3idpPmlVcJ8YHAkXCGQMmZNaDr%2F1eIfbzkJqXRCXc2HFLkg%3D%3D&bas_yy="+year+"&type=1&pageNo=1&numOfRows";
		
		// 1. 문서를 읽기위한 빌더팩토리를 만들어야 한다.
		DocumentBuilderFactory builderFactory = DocumentBuilderFactory.newInstance();
		
		// 2. 빌더 생성
		DocumentBuilder builder = builderFactory.newDocumentBuilder();
		
		// 3. url xml 파싱 
		Document doc = builder.parse(url);
		
		// 4. 문서 구조 안정화 ?  여기까지는 무조건 씀 
		doc.getDocumentElement().normalize(); 
				
		// xml에서 (노드리스트) ,  row라는 태그들을 찾음  
		NodeList nodeList = doc.getElementsByTagName("row");
		
		for(int i = 1; i <nodeList.getLength(); i++) {
			Node nNode = nodeList.item(i); // 궁금증
		    	    
		    if (nNode.getNodeType() == Node.ELEMENT_NODE) {
                Element element = (Element) nNode; //왜 하는거지?
                System.out.println("Name: " + element.getElementsByTagName("tot").item(0).getTextContent());
                }
		}
			
	}
}
