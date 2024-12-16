package com.stockm8.persistence;

import java.util.List;

import com.stockm8.domain.vo.OrderItemVO;
import com.stockm8.domain.vo.OrderVO;
import com.stockm8.domain.vo.ProductVO;
import com.stockm8.domain.vo.StockVO;


public interface OrderDAO {
	 // 주문 등록
    public void insertOrder(OrderVO order) throws Exception;
    
    // 주문 항목 등록
    public void insertOrderItem(OrderItemVO orderItem) throws Exception;
    
    // 주문과 주문항목을 한번에 처리
    public void insertOrderWithItems(OrderVO order) throws Exception;
    
    // 모든 재고 목록 조회
    public List<StockVO> findAvailableStocks() throws Exception;
    
    //주문번호 생성
    public String generateOrderNumber() throws Exception;
    
    
    // 재고의 예약 수량을 업데이트.. 이거는 뭐지..>>
    public void updateStockReservedQuantity(int stockId, int quantity) throws Exception;
} // OrderDAO
