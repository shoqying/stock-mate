package com.stockm8.persistence;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.stockm8.domain.vo.OrderItemVO;
import com.stockm8.domain.vo.OrderVO;
import com.stockm8.domain.vo.ProductVO;
import com.stockm8.domain.vo.StockVO;

@Repository
public class OrderDAOImpl implements OrderDAO {
    
    private static final Logger logger = LoggerFactory.getLogger(OrderDAOImpl.class);
    
    @Inject
    private SqlSession sqlSession;
    
    private static final String NAMESPACE = "com.stockm8.mapper.OrderMapper.";
    
    @Override
    public void insertOrder(OrderVO order) throws Exception {
    	
        sqlSession.insert(NAMESPACE + "insertOrder", order);
    }
    
    @Override
    public void insertOrderItem(OrderItemVO orderItem) throws Exception {
        sqlSession.insert(NAMESPACE + "insertOrderItem", orderItem);
    }
    
    @Override
    public List<StockVO> findAvailableStocks() throws Exception {
        return sqlSession.selectList(NAMESPACE + "findAvailableStocks");
    }

    @Override
    public void updateStockReservedQuantity(int stockId, int quantity) throws Exception {
        sqlSession.update(NAMESPACE + "updateStockReservedQuantity", 
            new java.util.HashMap<String, Object>() {{
                put("stockId", stockId);
                put("quantity", quantity);
            }}
        );
    }
    
    /**
     * 새로운 주문번호 생성
     * 동시성 제어를 위해 synchronized 키워드 사용
     * 형식: ORD-YYYYMMDD-###
     */

    @Override
    public synchronized String generateOrderNumber() throws Exception {
        // 현재 날짜 형식 지정
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        String date = sdf.format(new Date());
        
        // 해당 날짜의 마지막 주문번호 조회
        String lastOrderNumber = sqlSession.selectOne(NAMESPACE + "getLastOrderNumberForDate", date);
        
        // 시퀀스 번호 생성
        int sequence = 1;
        if (lastOrderNumber != null && !lastOrderNumber.isEmpty()) {
            String sequenceStr = lastOrderNumber.substring(lastOrderNumber.lastIndexOf("-") + 1);
            sequence = Integer.parseInt(sequenceStr) + 1;
        }
        
        // 주문번호 생성 및 반환
        return String.format("ORD-%s-%03d", date, sequence);
    }

	@Override
	public void insertOrderWithItems(OrderVO order) throws Exception {
		 // 주문 마스터 등록(Order 와 Orderitem 을 한번에 처리)
        sqlSession.insert(NAMESPACE + "insertOrder", order);
        
        // 생성된 주문 ID로 각 주문 항목 등록
        for (OrderItemVO item : order.getOrderItems()) {
            item.setOrderId(order.getOrderId());
            sqlSession.insert(NAMESPACE + "insertOrderItem", item);
        }
		
	}
} // OrderImpl