package com.stockm8.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.stockm8.domain.ProductVO;

@Repository
public class ProductDAOImpl implements ProductDAO {

	private static final Logger logger = LoggerFactory.getLogger(ProductDAOImpl.class);
	
	// 디비연결 객체 주입 
	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE = "com.stockm8.mappers.productMapper.";
	
	@Override
	public void insertProduct(ProductVO pVO) throws Exception {
		logger.info("insertProduct(ProductVO pVO) 호출");
		logger.info("DAO -> mapper(sql) 실행");
		
		// mapper 호출 및 실행 
		sqlSession.insert(NAMESPACE + "insertProduct", pVO);
		
	}

}
