package com.stockm8.controller;

import java.sql.Timestamp;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.stockm8.domain.CategoryVO;
import com.stockm8.service.CategoryService;

@Controller
@RequestMapping("/category")
public class CategoryController {

    @Inject
    private CategoryService cService;

    // 카테고리 등록 페이지 호출 (GET)
    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public String showRegisterPage() {
    	
    	// JSP 파일 경로: /WEB-INF/views/category/register.jsp
        return "category/register"; 
    }
    
    // http://localhost:8088/category/register
    // 카테고리 등록 처리 (POST)
    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public String registerCategory(CategoryVO vo) throws Exception {
        
        int businessId = 1;  // 예시로 설정 (실제 환경에서는 로그인된 사용자의 ID를 가져와야 함)
        
        // 상위 카테고리가 없으면 대분류(1), 있으면 소분류(2)로 설정
        if (vo.getParentId() == null) {
            vo.setLevel(1);  // 대분류
        } else {
            vo.setLevel(2);  // 소분류
        }
        
        // 카테고리 생성 시간 (현재 시간)
        vo.setCreatedAt(new Timestamp(System.currentTimeMillis()));
        
        // 서비스 호출
        cService.addCategory(vo);
        
        // 등록 후 목록 페이지로 리다이렉트
        return "redirect:/category/list";
    }

    // http://localhost:8088/category/list
    // 카테고리 목록 페이지 호출 (GET)
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String listCategories(Model model) throws Exception {
    	// 카테고리 목록 조회
        List<CategoryVO> categories = cService.getAllCategories(); 
        
        // JSP로 데이터 전달
        model.addAttribute("categories", categories); 
        // JSP 파일 경로: /WEB-INF/views/category/list.jsp
        return "category/list"; 
    }
}
