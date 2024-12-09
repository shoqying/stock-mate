package com.stockm8.service;

import com.stockm8.domain.vo.StockVO;
import com.stockm8.domain.vo.ProductVO;
import com.stockm8.domain.vo.WarehouseVO;  // 추가된 VO
import com.stockm8.domain.vo.CategoryVO;   // 추가된 VO

import java.util.List;

public interface StockService {

    // 사업자 ID에 해당하는 재고 목록 조회
    public List<StockVO> getAllStock(int businessId) throws Exception;

    // 필터링된 재고 목록 조회
    public List<StockVO> filterStocks(String warehouseName, String categoryName, String sortOrder) throws Exception;
    
    // 상품 ID로 상품 상세 조회
    public ProductVO getProductById(int productId) throws Exception;

    // 사용 가능한 재고 자동 계산
    public int calculateAvailableStock(StockVO stock) throws Exception;

    // 창고 목록 조회 (창고 정보 객체 반환)
    public List<WarehouseVO> getAllWarehouses() throws Exception;

    // 카테고리 목록 조회 (카테고리 정보 객체 반환)
    public List<CategoryVO> getAllCategories() throws Exception;
}
