package com.stockm8.persistence;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.stockm8.domain.vo.BusinessVO;

@Repository
public class BusinessDAOImpl implements BusinessDAO {
	
	// 디비연결 객체 주입 
	@Autowired
	private SqlSession sqlSession;	
	
	private static final String NAMESPACE = "com.stockm8.mapper.BusinessMapper.";


	@Override
	public void insertBusiness(BusinessVO business) throws Exception {
		
		// mapper 호출 및 실행 
		sqlSession.insert(NAMESPACE + "insertProduct", business);
	}

}
