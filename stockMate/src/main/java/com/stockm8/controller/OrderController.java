package com.stockm8.controller;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.stockm8.domain.vo.OrderItemVO;
import com.stockm8.domain.vo.OrderVO;
import com.stockm8.domain.vo.ProductVO;
import com.stockm8.service.OrderService;

@Controller
@RequestMapping(value = "/order")
public class OrderController {
    
    private static final Logger logger = LoggerFactory.getLogger(OrderController.class);
    
    @Inject
    private OrderService oSer;
    
    /**
     * 주문 등록 페이지 표시
     * http://localhost:8088/order/register
     */
    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public String OrderRegisterGET(Model model) throws Exception {
        logger.info("OrderRegisterGET() 호출");
        return "Order/OrderRegister"; // WEB-INF/views/Order/OrderRegister.jsp를 찾음
    }

//    /**
//     * 주문 등록 처리
//     */
//    @RequestMapping(value = "/register", method = RequestMethod.POST)
//    @ResponseBody
//    public String OrderRegisterPOST(@RequestBody OrderVO vo) throws Exception {
//        logger.info("OrderRegisterPOST() 호출");
//        logger.info("주문 정보: {}", vo);
//        
//        try {
//            // 현재 시간 설정
//            Timestamp currentTime = new Timestamp(System.currentTimeMillis());
//            vo.setCreatedAt(currentTime);
//            vo.setUpdatedAt(currentTime);
//            vo.setStatus("pending");
//            
//            // 주문항목들의 시간 설정
//            if (vo.getOrderItems() != null) {
//                for (OrderItemVO item : vo.getOrderItems()) {
//                    item.setCreatedAt(currentTime);
//                    item.setUpdatedAt(currentTime);
//                }
//            }
//            
//            // 주문 등록
//            oSer.insertOrder(vo);
//            
//            logger.info("주문등록 성공! 주문번호: {}", vo.getOrderNumber());
//            return "success";
//            
//        } catch (Exception e) {
//            logger.error("주문등록 실패: {}", e.getMessage());
//            throw e;
//        }
//    }
    
    /**
     * 전체 제품 목록 조회
     */
    @RequestMapping(value = "/findAllProducts",
                   method = RequestMethod.GET,
                   produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public List<ProductVO> findAllProducts() throws Exception {
        logger.info("findAllProducts() 호출");
        return oSer.findAllProducts();
    }
    
    /**
     * 주문번호 생성
     */
    @RequestMapping(value = "/generateOrderNumber", method = RequestMethod.GET)
    @ResponseBody
    public String generateOrderNumber() throws Exception {
        logger.info("generateOrderNumber() 호출");
        return oSer.generateOrderNumber();
    }
}
