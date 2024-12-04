package com.stockm8.service;

import com.stockm8.domain.ProductVO;

public interface ProductService {
	
	// 상품 등록 
	public void createProduct(ProductVO pVO) throws Exception;
	
}

