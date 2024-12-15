package com.stockm8.service;

import java.util.List;
import java.util.Map;

import com.stockm8.domain.vo.ProductVO;
import com.stockm8.domain.vo.StockVO;

public interface StockService {
	
	// 재고 등록
	public void registerStock(StockVO stock) throws Exception;

    // 사업자 ID에 해당하는 재고 목록 조회
    public List<StockVO> getStockListByBusinessId(int businessId) throws Exception;

    // 필터링된 재고 목록 조회
    public List<StockVO> filterStocks(String warehouseName, String categoryName, String sortOrder) throws Exception;
    
    // 상품 ID로 상품 상세 조회
    public ProductVO getProductById(int productId) throws Exception;

    // 사용 가능한 재고 자동 계산
    public int calculateAvailableStock(StockVO stock) throws Exception;
    
    // TKDJQWK ID로 재고정보와 카테고리 정보 가져오기 
    public Map<String, Object> getStockAndCategories(int businessId) throws Exception;

}
