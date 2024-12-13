package com.stockm8.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.stockm8.domain.vo.StockVO;
import com.stockm8.domain.vo.UserVO;
import com.stockm8.domain.vo.WarehouseVO;
import com.stockm8.persistence.FilterCriteria;
import com.stockm8.service.StockService;
import com.stockm8.service.UserService;
import com.stockm8.service.WarehouseService;

@Controller
@RequestMapping("/stock")
public class StockController {
    private static final Logger logger = LoggerFactory.getLogger(StockController.class);

    @Inject
    private StockService stockService;

    @Inject
    private UserService userService;

    @Inject
    private WarehouseService warehouseService;  // WarehouseService 주입

    // http://localhost:8088/stock/list
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String getStockList(StockVO stock, Model model, HttpServletRequest request,
                                @RequestParam(required = false) Integer warehouseId, 
                                @RequestParam(required = false) String categoryName, 
                                @RequestParam(required = false) Integer minStock, 
                                @RequestParam(required = false) Integer maxStock,
                                @RequestParam(required = false, defaultValue = "desc") String sortOrder) throws Exception {
        logger.info("getStockList 호출");

        // 세션에서 userId 가져오기 
        HttpSession session = request.getSession(false);
        Long userId = (session != null) ? (Long) session.getAttribute("userId") : null;
        
        // userId로 사용자 정보 조회
        UserVO user = userService.getUserById(userId);   

        int businessId = user.getBusinessId();
        stock.setBusinessId(businessId);

        // 창고 목록 조회 (businessId에 맞는 창고 목록)
        List<WarehouseVO> warehouseList = warehouseService.getWarehousesByBusinessId(businessId);
        logger.info("조회된 창고 목록: {}", warehouseList.size());

        // 창고명과 카테고리명 정보 제공
        model.addAttribute("warehouseList", warehouseList);
        model.addAttribute("categoryList", stockService.getCategoryList());

        // 재고 리스트 조회 (FilterCriteria 객체를 사용하여 파라미터 전달)
        FilterCriteria criteria = new FilterCriteria(warehouseId, categoryName, minStock, maxStock, sortOrder, businessId);
        List<StockVO> stockList = stockService.getStockList(criteria, sortOrder);  // 정렬 순서 추가
        model.addAttribute("stockList", stockList);
        
        // 필터링된 파라미터들을 모델에 추가
        model.addAttribute("warehouseId", warehouseId);
        model.addAttribute("categoryName", categoryName);
        model.addAttribute("minStock", minStock);
        model.addAttribute("maxStock", maxStock);
        model.addAttribute("sortOrder", sortOrder);  // 정렬 상태 추가

        // /stock/list.jsp로 포워딩
        return "/stock/list";
    }

    // 상품명 클릭 시 상품 상세 페이지로 리다이렉트
    @RequestMapping("/detail/{productId}")
    public String productDetail(@PathVariable("productId") int productId) {
        // 상품 상세 페이지로 리다이렉트
        logger.info("상품 상세 페이지로 이동: productId = {}", productId);
        return "redirect:/product/detail/" + productId;
    }
}