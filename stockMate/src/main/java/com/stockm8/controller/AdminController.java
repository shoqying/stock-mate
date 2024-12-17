package com.stockm8.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.stockm8.domain.vo.Criteria;
import com.stockm8.domain.vo.OrderItemVO;
import com.stockm8.domain.vo.OrderVO;
import com.stockm8.domain.vo.PageVO;
import com.stockm8.domain.vo.OrderVO.OrderType;
import com.stockm8.domain.vo.StockVO;
import com.stockm8.domain.vo.UserVO;
import com.stockm8.service.OrderService;
import com.stockm8.service.UserService;

@Controller
@RequestMapping(value = "/admin/*")
public class AdminController {
	
	// 현재 로그인한 사용자 정보 가져오기(인터셉터에서 정의됨)
	private UserVO getCurrentUser(HttpServletRequest request) {
        return (UserVO) request.getAttribute("currentUser");
    }
    
    private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
    
    @Inject
    private OrderService orderService;
    @Inject
    private UserService userService;
    
    /**
     * 어드민 메인 페이지 표시(GET)
     * http://localhost:8088/admin/adminMain
     * 
     */
    @RequestMapping(value = "/adminMain", method = RequestMethod.GET)
    public String adminMainGET(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
        logger.info("adminMainGET() 호출");
        
        UserVO currentUser = getCurrentUser(request);
        int businessId = currentUser.getBusinessId();
	    
	    return "admin/adminMain";
    }
    /**
     * 어드민 회원목록표시(GET)
     * http://localhost:8088/admin/adminList
     * 
     */
    @RequestMapping(value = "/adminList", method = RequestMethod.GET)
    public String adminListGET(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	logger.info("adminListGET() 호출");
    	
        UserVO currentUser = getCurrentUser(request);
        int businessId = currentUser.getBusinessId();
    	
    	return "admin/adminList";
    }


    
} //AdminController