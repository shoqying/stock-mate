package com.stockm8.persistence;

import com.stockm8.domain.vo.StockVO;
import com.stockm8.domain.vo.ProductVO;
import com.stockm8.domain.vo.WarehouseVO;
import com.stockm8.domain.vo.CategoryVO;

import java.util.List;

public interface StockDAO {
	
	// 재고 등록 
	public void insertStock(StockVO stock) throws Exception;

    // 사업자 ID에 해당하는 재고 목록 조회
    public List<StockVO> selectStockListByBusinessId(int businessId) throws Exception;

    public List<StockVO> selectOnlyStockByBusinessId(int businessId) throws Exception;
    
    // 상품 ID로 상품 상세 조회
    public ProductVO selectProductById(int productId) throws Exception;

    // 필터링된 재고 목록 조회
    public List<StockVO> selectFilteredStocks(String warehouseName, String categoryName, String sortOrder) throws Exception;
    
}
