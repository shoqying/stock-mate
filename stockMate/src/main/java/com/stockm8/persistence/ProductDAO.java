package com.stockm8.persistence;

import com.stockm8.domain.ProductVO;

public interface ProductDAO {
	
	// 상품 등록 
	public void insertProduct(ProductVO pVO) throws Exception;
}
