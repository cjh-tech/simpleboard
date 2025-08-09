package com.simpleboard.api;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

public class MovieApiGet {
		//JSON api 파일 가져오기 기능
	public  List<String> movieapiname() throws Exception{
				
		//현재 시간날짜 가져오기
		java.util.Calendar cal = java.util.Calendar.getInstance();
		java.text.DateFormat format = new java.text.SimpleDateFormat("yyyyMMdd");
		
		cal.add(cal.DATE, -7); // 7일(일주일)을 뺀다
		String dateStr = format.format(cal.getTime());
		
		String http = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchWeeklyBoxOfficeList.json?key=a51f1b45be8cfb1af5285a0ad618933c&targetDt="+dateStr;
		URL url = new URL(http);
		// (본인키값 부분에 영화진흥위원회 해당 기능 키값을 가져와야함 )
		BufferedReader bf;
		bf = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));
		
		String result = bf.readLine(); 
		
		List<String> datalist = new LinkedList<String>();
		//순서가 보장되는 LinkedHashMap
		
		JSONParser jsonParser = new JSONParser();
		JSONObject parsing = (JSONObject)jsonParser.parse(result); // 문자열을 json으로 파싱한 상태
		JSONObject boxOfficeResult = (JSONObject)parsing.get("boxOfficeResult"); // parsing한 상태에서  "boxOfficeResult"부분 가져옴 
		JSONArray list = (JSONArray)boxOfficeResult.get("weeklyBoxOfficeList"); // [ ] 대괄호부분을 가져오는 방법 
		//list형식으로 인덱스번호로 나열되어있음 
		
		for(int i = 0 ; i < 6; i++) {
			JSONObject tmp = (JSONObject) list.get(i);
			datalist.add(i,(String)tmp.get("movieNm"));
			
		}
					
		return datalist;
	}
	
	public  List<String> movieapiaudi() throws Exception{
		
		//현재 시간날짜 가져오기
		java.util.Calendar cal = java.util.Calendar.getInstance();
		java.text.DateFormat format = new java.text.SimpleDateFormat("yyyyMMdd");

		cal.add(cal.DATE, -7); // 7일(일주일)을 뺀다
		String dateStr = format.format(cal.getTime());
		
		String http = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchWeeklyBoxOfficeList.json?key=a51f1b45be8cfb1af5285a0ad618933c&targetDt="+dateStr;
		URL url = new URL(http);
		// (본인키값 부분에 영화진흥위원회 해당 기능 키값을 가져와야함 )
		BufferedReader bf;
		bf = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));
		
		String result = bf.readLine(); 
		
		List<String> datalist = new LinkedList<String>();
		//순서가 보장되는 LinkedHashMap
		
		JSONParser jsonParser = new JSONParser();
		JSONObject parsing = (JSONObject)jsonParser.parse(result); // 문자열을 json으로 파싱한 상태
		JSONObject boxOfficeResult = (JSONObject)parsing.get("boxOfficeResult"); // parsing한 상태에서  "boxOfficeResult"부분 가져옴 
		JSONArray list = (JSONArray)boxOfficeResult.get("weeklyBoxOfficeList"); // [ ] 대괄호부분을 가져오는 방법 
		//list형식으로 인덱스번호로 나열되어있음 
		
		for(int i = 0 ; i < 6; i++) {
			JSONObject tmp = (JSONObject) list.get(i);
			datalist.add(i,(String)tmp.get("audiAcc"));
			
		}
					
		return datalist;
	}
	
	
}
