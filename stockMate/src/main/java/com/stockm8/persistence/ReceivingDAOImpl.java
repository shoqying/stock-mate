package com.stockm8.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.stockm8.domain.vo.Criteria;
import com.stockm8.domain.vo.ReceivingShipmentVO;

@Repository
public class ReceivingDAOImpl implements ReceivingDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(ReceivingDAOImpl.class);
	
	private static final String NAMESPACE = "com.stockm8.mappers.receivingMapper.";
	
	// 디비 연결 객체 주입
	@Inject
	private SqlSession sqlSession;
	
	// 입고 메인 오늘 들어올 리스트
	@Override
	public List<ReceivingShipmentVO> selectReceivingList(int businessId) throws Exception {
		logger.info("ReceivingList() 호출");
		
		return sqlSession.selectList(NAMESPACE + "getReceivingList", businessId); 
	}
	
	// 입고 메인 오늘 들어올 리스트
	@Override
	public List<ReceivingShipmentVO> selectYesterdayReceivingList(int businessId) throws Exception {
		logger.info("ReceivingList() 호출");
		
		return sqlSession.selectList(NAMESPACE + "getYesterdayReceivingList", businessId); 
	}
		
	// 입고 메인 오늘 들어올 리스트
	@Override
	public List<ReceivingShipmentVO> selectTDBYReceivingList(int businessId) throws Exception {
		logger.info("ReceivingList() 호출");
		
		return sqlSession.selectList(NAMESPACE + "getTDBYReceivingList", businessId); 
	}
	
	// 입고 내역 히스토리 리스트
	@Override
	public List<ReceivingShipmentVO> selectReceivingHistoryList(Criteria cri, int businessId) throws Exception {
		logger.info("selectReceivingHistoryList() 호출");
		
		Map<String, Object> paramMap = new HashMap();
		paramMap.put("cri", cri);
		paramMap.put("businessId", businessId);	   
		
		return sqlSession.selectList(NAMESPACE + "getReceivingHistoryList", paramMap);
	}

	// 입고 내역 검색
	@Override
	public List<ReceivingShipmentVO> selectHistoryByDateRange(String startDate, String endDate, String keyword, Criteria cri, int businessId) throws Exception {
		logger.info("selectHistoryByDateRange() 호출");
		
	    Map<String, Object> paramMap = new HashMap();
	    paramMap.put("startDate", startDate);
	    paramMap.put("endDate", endDate);
	    paramMap.put("keyword", keyword);
	    paramMap.put("cri", cri);
	    paramMap.put("businessId", businessId);	    
	    
		return sqlSession.selectList(NAMESPACE + "getHistoryByDateRange", paramMap);
	}

	@Override
	public int selectTotalCountBySearch(String startDate, String endDate, String keyword, int businessId) throws Exception {
	    
		Map<String, Object> paramMap = new HashMap<>();
	    paramMap.put("startDate", startDate);
	    paramMap.put("endDate", endDate);
	    paramMap.put("keyword", keyword);
	    paramMap.put("businessId", businessId);	
	    return sqlSession.selectOne(NAMESPACE + "getTotalCountBySearch", paramMap);
	}
	
	@Override
	public int selectTotalCount(int businessId) throws Exception {
		logger.info("selectTotalCount() 호출");
		
		return sqlSession.selectOne(NAMESPACE + "getTotalCount", businessId);
	}

	@Override
	public void insertReceiving(int businessId) throws Exception {
		logger.info("insertReceiving() 호출");
		sqlSession.insert(NAMESPACE + "insertReceiving", businessId);
	}
	
	
	
	
	
	
	
	

} // ReceivingDAOImpl end
