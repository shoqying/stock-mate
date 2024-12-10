package com.stockm8.service;

import java.util.List;
import javax.inject.Inject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.stockm8.domain.vo.OrderItemVO;
import com.stockm8.domain.vo.OrderVO;  // OrderItemVO import 제거
import com.stockm8.domain.vo.ProductVO;
import com.stockm8.persistence.OrderDAO;

@Service
public class OrderServiceImpl implements OrderService {
    
    private static final Logger logger = LoggerFactory.getLogger(OrderServiceImpl.class);
    
    @Inject
    private OrderDAO odao;
    
    @Override
    @Transactional
    public void insertOrder(OrderVO order, OrderItemVO orderItem) throws Exception {
        // 주문 등록
        odao.insertOrder(order);
        
        // 생성된 주문 ID를 주문항목에 설정
        orderItem.setOrderId(order.getOrderId());
        
        // 주문항목 등록
        odao.insertOrderItem(orderItem);
    }
    
    @Override
    public String generateOrderNumber() throws Exception {
        return odao.generateOrderNumber();
    }

	@Override
    public List<ProductVO> findAllProducts() throws Exception {
        return odao.findAllProducts();
    }
}