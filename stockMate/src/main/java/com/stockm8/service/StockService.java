package com.stockm8.service;

import com.stockm8.domain.vo.StockVO;
import com.stockm8.domain.vo.WarehouseVO;  // 추가된 VO
import com.stockm8.persistence.FilterCriteria;
import com.stockm8.domain.vo.CategoryVO;   // 추가된 VO

import java.util.List;

public interface StockService {

    // 사업자 ID에 해당하는 창고 목록 조회
    public List<WarehouseVO> getWarehousesByBusinessId(int businessId) throws Exception;

    // 필터링된 재고 목록 조회 (정렬 기준 추가)
    public List<StockVO> getStockList(FilterCriteria criteria, String sortOrder) throws Exception;  // sortOrder 추가

    // 카테고리 목록 조회
    public List<CategoryVO> getCategoryList() throws Exception;
}