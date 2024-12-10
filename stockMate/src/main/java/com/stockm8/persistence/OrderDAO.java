package com.stockm8.persistence;

import java.util.List;

import com.stockm8.domain.vo.OrderItemVO;
import com.stockm8.domain.vo.OrderVO;
import com.stockm8.domain.vo.ProductVO;


public interface OrderDAO {
	 // 주문 등록
    public void insertOrder(OrderVO order) throws Exception;
    
    // 주문 항목 등록
    public void insertOrderItem(OrderItemVO orderItem) throws Exception;
    
    // 모든 제품 목록 조회
    public List<ProductVO> findAllProducts() throws Exception;
    
    //주문번호 생성
    public String generateOrderNumber() throws Exception;
}
