package com.todoc.board;

import java.util.List;

import org.springframework.context.support.GenericXmlApplicationContext;

public class BoardServiceClient {

	public static void main(String[] args) {
		System.out.println("--- 스프링 컨테이너 구동전 ----");
		//1. 스프링 컨테이너 구동(XML 파일 읽어서)
		GenericXmlApplicationContext container
			= new GenericXmlApplicationContext("applicationContext.xml");
		
		System.out.println("--- 스프링 컨테이너 구동후 ----");
		//2. 스프링 컨테이너 사용
		BoardService boardService = (BoardService) container.getBean("boardService");
		
		BoardVO vo = new BoardVO();
		vo.setTitle("제목-spring");
		vo.setUseridx(1);
		vo.setContent("내용-spring");
		
		boardService.insertBoard(vo);
		
		List<BoardVO> list = boardService.getBoardList(new BoardVO());
		for (BoardVO board : list) {
			System.out.println(board);
		}
		
		//3. 스프링 컨테이너 종료(close)
		container.close();
	}

}
