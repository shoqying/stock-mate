package com.stockm8.persistence;

import com.stockm8.domain.vo.CategoryVO;
import com.stockm8.domain.vo.StockVO;

import java.util.List;

public interface StockDAO {

    // 필터링된 재고 목록 조회 (정렬 기준 포함)
    public List<StockVO> selectFilteredStocks(FilterCriteria criteria, String sortOrder) throws Exception;

    // 카테고리 목록 조회
    public List<CategoryVO> selectCategoryList() throws Exception;  
}