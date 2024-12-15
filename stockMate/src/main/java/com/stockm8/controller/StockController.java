package com.stockm8.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.stockm8.domain.vo.CategoryVO;
import com.stockm8.domain.vo.StockVO;
import com.stockm8.domain.vo.UserVO;
import com.stockm8.service.CategoryService;
import com.stockm8.service.ProductService;
import com.stockm8.service.StockService;
import com.stockm8.service.UserService;
import com.stockm8.service.WarehouseService;

@Controller
@RequestMapping(value = "/stock/*")  // 모든 요청이 /stock으로 시작합니다.
public class StockController {
	
	private static final Logger logger = LoggerFactory.getLogger(StockController.class);

    @Inject
    private StockService stockService;
    
    @Autowired
    private UserService userService;
    
    @Autowired
    private CategoryService categoryService;
    
    @Autowired
    private WarehouseService warehouseService;
    
    @Autowired
    private ProductService productService;
    
    // http://localhost:8088/stock/register
    /**
     * 재고 등록 페이지 
     */
    @GetMapping("/register")
    public String stockRegisterGET(@SessionAttribute("userId") Long userId, Model model) throws Exception {
        logger.info("Fetching stock register page for userId: {}", userId);

        // 사용자 정보 가져오기
        UserVO user = userService.getUserById(userId);
        int businessId = user.getBusinessId();
        logger.info("Business ID for user: {}", businessId);

        // 모델에 데이터 추가
        model.addAttribute("businessId", businessId);

        return "/stock/register";
    }
    
    // 재고 등록 처리
    @PostMapping("/stock/register")
    public String registerStock(@ModelAttribute StockVO stock, @SessionAttribute("userId") Long userId, Model model) throws Exception {
	        
    	// 사용자 정보 가져오기
        UserVO user = userService.getUserById(userId);
        int businessId = user.getBusinessId();

        // StockVO에 추가 데이터 설정
        stock.setBusinessId(businessId);
        stock.setReservedQuantity(0); // 초기 예약 수량은 0
        stock.setAvailableStock(stock.getTotalQuantity()); // 초기 재고 = 입력 수량

        // 재고 등록 서비스 호출
        stockService.registerStock(stock);

        model.addAttribute("success", "재고 등록이 성공적으로 완료되었습니다.");
        return "redirect:/stock/list"; // 재고 목록 페이지로 이동
    } 

    
    // http://localhost:8088/stock/list
    /**
     * 비즈니스 ID를 기반으로 재고 목록 조회
     */
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String list(@SessionAttribute("userId") Long userId, Model model) throws Exception {
        logger.info("Fetching stock list for userId: {}", userId);

        UserVO user = userService.getUserById(userId);
        int businessId = user.getBusinessId();
        logger.info("Business ID for user: {}", businessId);

        // 재고 및 카테고리 데이터 조회
        List<StockVO> stockList = stockService.getStockListByBusinessId(businessId);
        List<CategoryVO> categoryList = categoryService.getCategoriesByBusinessId(businessId);

        logger.info("Fetched stockList: {}", stockList);
        logger.info("Fetched categoryList: {}", categoryList);

        model.addAttribute("stockList", stockList);
        model.addAttribute("categoryList", categoryList);

        return "/stock/list";
    }
}