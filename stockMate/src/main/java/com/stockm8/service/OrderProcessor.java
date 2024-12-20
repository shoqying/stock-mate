package com.stockm8.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.stockm8.controller.OrderController;
import com.stockm8.domain.enums.OrderStatus;
import com.stockm8.domain.enums.OrderType;
import com.stockm8.domain.vo.OrderItemVO;
import com.stockm8.domain.vo.OrderVO;

@Service
public class OrderProcessor {
    @Inject
    private OrderService orderService;
    @Inject
    private ReceivingService receivingService;
    @Inject
    private ShipmentService shipmentService;
    
    /**
     * 주문 등록 처리
     * 1. 유효성 검사
     * 2. 주문번호 생성
     * 3. 주문 등록
     * 4. 입출고 처리 (OUTBOUND는 즉시처리, INBOUND는 pending 상태로 처리)
     * 
     * 파라메터 order 주문 정보
     * 파라메터 businessId 사업자 ID
     * 리턴 처리 결과 및 주문번호를 포함한 응답
     */
    
    private static final Logger logger = LoggerFactory.getLogger(OrderController.class);
    @Transactional(rollbackFor = Exception.class)
    public Map<String, String> process(OrderVO order, int businessId) throws Exception {
    	
    	
        // 1. 유효성 검사
        validateOrder(order);
        
        // 2. 주문번호 생성 및 설정
        String orderNumber = orderService.generateOrderNumber();
        order.setOrderNumber(orderNumber);
        order.setStatus(OrderStatus.PENDING);
        
        // 3. 주문 처리
        orderService.insertOrderWithItems(order, order.getOrderItems(), businessId);
        
        // 4. 입출고 처리
        // 수주(출고)는 바로 처리
        if (order.getOrderType() == OrderType.OUTBOUND) {
            shipmentService.insertShipment(businessId);
        } else {
            // 발주(입고)는 pending 상태로만 처리
            receivingService.insertReceiving(businessId);
        }
        
        // 5. 응답 생성
        Map<String, String> response = new HashMap<>();
        response.put("status", "success");
        response.put("message", "주문이 성공적으로 등록되었습니다.");
        response.put("orderNumber", orderNumber);
        
        logger.info("주문 등록 완료 - 주문번호: {}", orderNumber);
        return response;
    }
    
    /**
     * 검수 완료 후 재고 처리
     * 발주(INBOUND) 주문에 대한 검수가 완료된 후 재고를 업데이트
     * 
     * 파라메터 orderId 주문 ID
     * 파라메터 completedItems 검수 완료된 항목 목록
     * 예외 IllegalStateException 발주 주문이 아닌 경우
     */
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
    
    /**
     * 주문 유효성 검사
     * 1. 주문 유형 검사
     * 2. 주문 항목 존재 여부 검사
     * 3. 수주(OUTBOUND)인 경우 재고 가용성 검사
     * 
     * 파라메터 order 검사할 주문 정보
     * 예외 IllegalArgumentException 유효성 검사 실패시
     */
    private void validateOrder(OrderVO order) throws Exception {
        // orderType 검사
        if (order.getOrderType() == null) {
            throw new IllegalArgumentException("주문 유형이 누락되었습니다.");
        }
        
        // orderItems 검사
        if (order.getOrderItems() == null || order.getOrderItems().isEmpty()) {
            throw new IllegalArgumentException("주문 항목이 누락되었습니다.");
        }
        
        // 재고 검증 (수주의 경우)
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

