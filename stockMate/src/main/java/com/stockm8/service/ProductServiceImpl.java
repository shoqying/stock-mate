package com.stockm8.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.stockm8.domain.vo.ProductVO;

@Service
public class ProductServiceImpl implements ProductService {
	
	private static final Logger logger = LoggerFactory.getLogger(ProductServiceImpl.class);
	
	
	
	@Override
	public void createProduct(ProductVO pVO) throws Exception {
		logger.info("insert(ProductVO pVO) 호출");
		logger.info("Service -> DAO Method 호출");
		
		//DAO 메서드 호출
	}

}
