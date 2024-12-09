package com.stockm8.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.stockm8.domain.vo.StockVO;
import com.stockm8.service.StockService;

@Controller
@RequestMapping("/stock")  // 모든 요청이 /stock으로 시작합니다.
public class StockController {

    @Inject
    private StockService stockService;

    // 사업자별 재고 목록 조회
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String list(Model model, @RequestParam int businessId) throws Exception {
        // 사업자에 속한 재고 목록을 서비스에서 조회
        List<StockVO> stockList = stockService.getAllStock(businessId);

        // 조회된 재고 목록을 JSP로 전달
        model.addAttribute("stockList", stockList);

        // /stock/list.jsp로 포워딩
        return "/stock/list";
    }

    // 필터링된 재고 목록 조회
    @RequestMapping(value = "/filter", method = RequestMethod.GET)
    public String filter(Model model,
                         @RequestParam(required = false) String warehouseName,
                         @RequestParam(required = false) String categoryName,
                         @RequestParam(required = false, defaultValue = "desc") String sortOrder) throws Exception {
        // sortOrder 파라미터 전달 (기본값은 'desc'로 설정)
        List<StockVO> stockList = stockService.filterStocks(warehouseName, categoryName, sortOrder);

        // 모델에 필요한 데이터 추가
        model.addAttribute("stockList", stockList);
        model.addAttribute("warehouseList", stockService.getAllWarehouses());  // 창고 목록
        model.addAttribute("categoryList", stockService.getAllCategories());  // 카테고리 목록
        model.addAttribute("sortOrder", sortOrder);  // sortOrder 파라미터 전달

        return "/stock/list";
    }
}