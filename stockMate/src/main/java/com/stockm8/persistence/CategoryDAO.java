package com.stockm8.persistence;

import java.util.List;

import com.stockm8.domain.vo.CategoryVO;

public interface CategoryDAO {
	
	// 카테고리 등록
    public void insertCategory(CategoryVO vo) throws Exception;
    
    // 카테고리 목록 조회
    public List<CategoryVO> selectAllCategories() throws Exception; 
}
