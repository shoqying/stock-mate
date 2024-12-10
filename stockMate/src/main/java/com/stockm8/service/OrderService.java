package com.stockm8.service;

import java.util.List;

import com.stockm8.domain.vo.OrderItemVO;
import com.stockm8.domain.vo.OrderVO;
import com.stockm8.domain.vo.ProductVO;  

public interface OrderService {
	// 주문 등록 (주문항목 포함)
    public void insertOrder(OrderVO order, OrderItemVO orderItem) throws Exception;
    
    // 모든 제품 목록 조회
    public List<ProductVO> findAllProducts() throws Exception;
    
    // 주문번호 생성
    public String generateOrderNumber() throws Exception;
}