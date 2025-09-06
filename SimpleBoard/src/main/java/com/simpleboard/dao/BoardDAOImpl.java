package com.simpleboard.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.simpleboard.vo.BoardVO;
import com.simpleboard.vo.SearchCriteria;

@Repository //빈(객체)로 생성 스프링 컨테이너에서 가지고 있다가  컨트롤러 부분에서 사용된다고 추정
public class BoardDAOImpl implements BoardDAO {

	@Inject
	private SqlSession sqlSession;
	// new로 객체생성없이 Inject로 객체생성(빈)함 그래도 위에서 import 되는 부분은 있음  // mapper.xml 부분들과 연결 mybatis 사용법인듯?
	// SqlSession은 db와 연결된 객체아닐까 생각함 여러 메서드를 가지고 있는듯함
	
	// 게시물 작성 
	@Override // 이건 인터페이스의 추상메서드를 구체화 한거임 스프링과 관계는 없음 
	public void write(BoardVO boardVO) throws Exception {
		
		sqlSession.insert("boardMapper.insert", boardVO);
		//        .insert 부분은 따로만든 메서드가 아니라 sqlSession안에 있는 메서드이다. 
	}
	// 극초기 리스트 호출
	@Override
	public List<BoardVO> list() throws Exception{
		return sqlSession.selectList("boardMapper.list");
	}
	// 게시물 읽기
	@Override
	public BoardVO read(int bno) throws Exception{
		System.out.println("bno "+bno);
		return sqlSession.selectOne("boardMapper.read",bno);
	}
	// 게시물 업데이트
	@Override
	public void update(BoardVO boardVO) throws Exception {
		
		sqlSession.update("boardMapper.update", boardVO);
	}

	// 게시물 삭제
	@Override
	public void delete(int bno) throws Exception {
		
		sqlSession.delete("boardMapper.delete", bno);
	}
	
	// 게시물 목록 조회
	@Override
	public List<BoardVO> list(SearchCriteria scri) throws Exception{
		return sqlSession.selectList("boardMapper.listPage", scri);
	}
	
	// 게시물 총 갯수
	@Override
	public int listCount(SearchCriteria scri) throws Exception{
		return sqlSession.selectOne("boardMapper.listCount", scri);
	}
}
