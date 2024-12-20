package com.stockm8.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.stockm8.domain.vo.OrderItemVO;
import com.stockm8.domain.vo.OrderVO;
import com.stockm8.domain.vo.OrderVO.OrderType;

@Service
public class OrderProcessor {
	 @Inject
	 private OrderService orderService;
	 @Inject
	 private ReceivingService receivingService;
	 @Inject
	 private ShipmentService shipmentService;
	 
	 
	 //주문 등록 처리 
	 @Transactional(rollbackFor = Exception.class)
	 public Map<String, String> process(OrderVO order, int businessId, Long userId) throws Exception {
	     
		 // 1. 유효성 검사
	     validateOrder(order);
	     
	     // 2. 주문번호 생성 및 설정
	     String orderNumber = orderService.generateOrderNumber();
	     order.setOrderNumber(orderNumber);
	     
	     // 3. 주문 처리
	     orderService.insertOrderWithItems(order, order.getOrderItems(), businessId);
	     
	     // 4. 입출고 처리
	     
	     // 수주(출고)는 바로 처리
	     if (order.getOrderType() == OrderType.OUTBOUND) {
	    	 shipmentService.insertShipment(businessId);
	    	 
	     } else {
	    // 발주(입고)는 pending 상태로만 
	    	 receivingService.insertReceiving(businessId, userId);
	     }
	     
	     // 5. 응답 생성
	     Map<String, String> response = new HashMap<>();
	     response.put("status", "success");
	     response.put("message", "주문이 성공적으로 등록되었습니다.");
	     response.put("orderNumber", orderNumber);
	     
	     return response;
	 }
	 //검수 완료 후 재고 처리
	    @Transactional(rollbackFor = Exception.class)
	    public void processInboundAfterInspection(int orderId, List<OrderItemVO> completedItems) throws Exception {
	        // 주문 정보 조회
	        OrderVO order = orderService.getOrderById(orderId);
	        
	        // 주문 타입 검증
	        if (order.getOrderType() != OrderType.INBOUND) {
	            throw new IllegalStateException("발주 주문이 아닙니다.");
	        }
	        
	        // 검수 완료된 항목들의 재고 업데이트
	        for (OrderItemVO item : completedItems) {
	            orderService.updateStockQuantity(item.getStockId(), -item.getQuantity());
	        }
	    }
	 
	 
	 // 유효성 검사 메서드
	 private void validateOrder(OrderVO order) throws Exception {
	     // orderType 검사
	     if (order.getOrderType() == null) {
	         throw new IllegalArgumentException("주문 유형이 누락되었습니다.");
	     }
	     
	     // orderItems 검사
	     if (order.getOrderItems() == null || order.getOrderItems().isEmpty()) {
	         throw new IllegalArgumentException("주문 항목이 누락되었습니다.");
	     }
	     
	     // 재고 검증
	     for (OrderItemVO item : order.getOrderItems()) {
	         if (order.getOrderType() == OrderType.OUTBOUND) {
	             if (!orderService.checkAvailableStock(item, order.getOrderType())) {
	                 throw new IllegalArgumentException(
	                     String.format("재고 부족 - StockId: %d, 요청수량: %d", 
	                         item.getStockId(), item.getQuantity())
	                 );
	             }
	         }
	     }
	 }
}// OrderProcessor
	
	