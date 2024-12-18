package com.stockm8.service;

import java.util.List;

import com.stockm8.domain.vo.Criteria;
import com.stockm8.domain.vo.OrderItemVO;
import com.stockm8.domain.vo.OrderVO;
import com.stockm8.domain.vo.ProductVO;
import com.stockm8.domain.vo.StockVO;  

public interface OrderService {
	
    // 주문항목을 한꺼번에 처리
    public void insertOrderWithItems(OrderVO order, List<OrderItemVO> orderItems, int businessId) throws Exception;
    
    //  재고 목록 조회
    public List<StockVO> findAvailableStocks(int businessId) throws Exception;
    
    // 주문번호 생성
    public String generateOrderNumber() throws Exception;
    
    // 재고 수량 업데이트
    public void updateStockQuantity(int stockId, int quantity) throws Exception;
    
    // 주문목록(페이징 추가)
    public List<OrderVO> getOrderList(Criteria cri, int businessId);
    
    // 주문 단건 조회
    public OrderVO getOrderById(int orderId) throws Exception;
    
    // 주문 상세 항목 목록 조회
    public List<OrderItemVO> getOrderItemsByOrderId(int orderId) throws Exception;
    
    // 가용 재고 체크 미사용
    public boolean checkAvailableStock(OrderItemVO item) throws Exception;
    
    // 전체 주문 개수 조회 (페이징 계산)
    public int getTotalOrderCount(int businessId);
    
    
} //OrderService
