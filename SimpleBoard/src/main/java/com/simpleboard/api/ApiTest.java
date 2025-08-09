package com.simpleboard.api;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class ApiTest {

	@Scheduled(fixedDelay = 10000000)
	public static void test() {
		System.out.println("경과");
	}

	// 스케쥴러 예시 트래픽회수를 감안해 미리제작
}
