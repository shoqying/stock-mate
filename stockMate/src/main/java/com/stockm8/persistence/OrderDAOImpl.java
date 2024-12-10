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
    public List<ProductVO> findAllProducts() throws Exception {
        return sqlSession.selectList(NAMESPACE + "findAllProducts");
    }

    @Override
    public String generateOrderNumber() throws Exception {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        String date = sdf.format(new Date());
        
        // 해당 날짜의 마지막 주문번호 조회
        String lastOrderNumber = sqlSession.selectOne(NAMESPACE + "getLastOrderNumberForDate", date);
        
        int sequence = 1;
        if (lastOrderNumber != null && !lastOrderNumber.isEmpty()) {
            // 마지막 주문번호에서 시퀀스 추출 (ORD-20241210-001에서 001 부분)
            String sequenceStr = lastOrderNumber.substring(lastOrderNumber.lastIndexOf("-") + 1);
            sequence = Integer.parseInt(sequenceStr) + 1;
        }
        
        return String.format("ORD-%s-%03d", date, sequence);
    }
}