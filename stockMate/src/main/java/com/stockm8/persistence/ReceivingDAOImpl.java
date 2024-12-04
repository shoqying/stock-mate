package com.stockm8.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.stockm8.domain.ReceivingVO;

@Repository
public class ReceivingDAOImpl implements ReceivingDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(ReceivingDAOImpl.class);
	
	private static final String NAMESPACE = "com.stockm8.mappers.receivingMapper.";
	
	// 디비 연결 객체 주입
	@Inject
	private SqlSession sqlSession;
	
	// 입고 메인 오늘 들어올 리스트
	public List<ReceivingVO> selectTodayReceivingList() throws Exception {
		logger.info("todayReceivingList() 호출");
		
		return sqlSession.selectList(NAMESPACE + "getTodayReceivingList"); 
	}

} // ReceivingDAOImpl end
