package com.stockm8.persistence;

import java.util.List;
import java.util.Map;

import com.stockm8.domain.vo.Criteria;
import com.stockm8.domain.vo.OrderItemVO;
import com.stockm8.domain.vo.OrderVO;
import com.stockm8.domain.vo.ProductVO;
import com.stockm8.domain.vo.StockVO;


public interface OrderDAO {
	 // 주문 등록
    public void insertOrder(OrderVO order) throws Exception;
    
    // 주문 항목 등록
    public void insertOrderItem(List<OrderItemVO> orderItem) throws Exception;
    
    // 모든 재고 목록 조회
    public List<StockVO> findAvailableStocks(int businessId) throws Exception;
    
    // 주문번호 생성
    public String generateOrderNumber() throws Exception;
    
    // 재고 수량 업데이트
    public int updateStockQuantity(Map<String, Object> params) throws Exception;
    
    // 주문 목록( 페이징 추가로 수정)
    public List<OrderVO> getOrderList(Criteria cri, int businessId);
    
    // 주문 단건 조회
    public OrderVO getOrderById(int orderId) throws Exception;
    
    // 주문 상세 항목 목록 조회
    public List<OrderItemVO> getOrderItemsByOrderId(int orderId) throws Exception;
    
    // 가용재고 정보 조회 
    public StockVO getStockById(int stockId) throws Exception;
    
    // 전체 주문 개수 조회 (페이징 계산)
    public int getTotalOrderCount(int businessId);
    
    // 오더아이디 
    public int getOrderIdByOrderItemId(Integer orderItemId) throws Exception;
    
    // 스톡아이디
    public int getStockIdByOrderItemId(Integer orderItemId) throws Exception;
    
    
} // OrderDAO
