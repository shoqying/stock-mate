package com.stockm8.service;

import java.util.List;
import com.stockm8.domain.CategoryVO;

public interface CategoryService {
	
	// 카테고리 등록
    public void addCategory(CategoryVO categoryVO) throws Exception;
    
    // 카테고리 목록 조회
    public List<CategoryVO> getAllCategories() throws Exception; 
}
