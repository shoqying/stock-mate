package com.stockm8.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.stockm8.domain.vo.CategoryVO;
import com.stockm8.service.CategoryService;

@Controller
@RequestMapping("/category")
public class CategoryController {

    @Inject
    private CategoryService cService;
    
    // 카테고리 등록 페이지 호출 (GET)
    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public String registerCategoryGET(Model model) throws Exception {
        // 필요한 데이터 (예: 상위 카테고리 목록 등) 전달
        List<CategoryVO> parentCategories = cService.getAllCategories(); 
        model.addAttribute("parentCategories", parentCategories);

        // 카테고리 등록 폼을 보여주는 페이지로 이동
        return "category/register"; 
    }

    // 카테고리 등록 처리 (POST)
    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public String registerCategoryPOST(CategoryVO vo) throws Exception {
        // 서비스 호출: 부모 카테고리 체크와 카테고리 등록을 서비스에서 처리
        cService.registerCategoryWithParentCheck(vo);

        // 등록 후 목록 페이지로 리다이렉트
        return "redirect:/category/list";
    }

    // 카테고리 목록 페이지 호출 (GET)
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String listCategoryGET(Model model) throws Exception {
        // 카테고리 목록 조회
        List<CategoryVO> categories = cService.getAllCategories(); 
        
        // JSP로 데이터 전달
        model.addAttribute("categories", categories); 
        return "category/list"; 
    }

    // 카테고리 수정 페이지 (GET)
    @RequestMapping(value = "/edit", method = RequestMethod.GET)
    public String editCategoryGET(@RequestParam("categoryId") int categoryId, Model model) throws Exception {
        // 카테고리와 상위 카테고리 정보 가져오기
        CategoryVO category = cService.getCategoryWithParents(categoryId);
        model.addAttribute("category", category);

        // 상위 카테고리 정보
        if (category.getParentId() != null) {
            CategoryVO parentCategory = cService.getCategoryWithParents(category.getParentId());
            model.addAttribute("parentCategory", parentCategory);
        }

        return "category/edit";
    }

    // 카테고리 수정 처리 (POST)
    @RequestMapping(value = "/edit", method = RequestMethod.POST)
    public String editCategoryPOST(@ModelAttribute CategoryVO vo) throws Exception {
        cService.updateCategory(vo);
        return "redirect:/category/list";
    }

    // 카테고리 삭제 페이지 (GET)
    @RequestMapping(value = "/delete", method = RequestMethod.GET)
    public String deleteCategoryGET(@RequestParam("categoryId") int categoryId, Model model) throws Exception {
        // 삭제할 카테고리 정보 가져오기
        CategoryVO category = cService.getCategoryWithParents(categoryId);
        model.addAttribute("category", category);

        return "category/delete";
    }

    // 카테고리 삭제 처리 (POST)
    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    public String deleteCategoryPOST(@RequestParam("categoryId") int categoryId) throws Exception {
        // 카테고리 삭제 처리
        cService.deleteCategory(categoryId);

        return "redirect:/category/list";
    }
}
