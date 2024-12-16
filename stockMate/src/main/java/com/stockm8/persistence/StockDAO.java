package com.stockm8.persistence;

import com.stockm8.domain.vo.CategoryVO;
import com.stockm8.domain.vo.StockVO;

import java.util.List;

public interface StockDAO {
	
	// 재고 등록
    public void insertStock(StockVO stock) throws Exception;

    // 필터링된 재고 목록 조회 (정렬 기준 포함)
    public List<StockVO> selectFilteredStocks(FilterCriteria criteria, String sortOrder) throws Exception;
    
    // 사업자 ID에 해당하는 재고 목록 조회
    public List<StockVO> selectStockListByBusinessId(int businessId) throws Exception;
    
    // 사업자 ID에 해당하는 재고 목록 조회 (단순 조회)
    public List<StockVO> selectOnlyStockByBusinessId(int businessId) throws Exception;

    // 카테고리 목록 조회
    public List<CategoryVO> selectAllCategories() throws Exception;

    // 조한수씨 메서드
    // 바코드로 재고 조회
  	public List<StockVO> selectQuantityCheckByBarcode(int businessId, String barcode) throws Exception;
 	
   	// 바코드로 재고 감소
  	public int updateIncreseStock(int businessId, String barcode) throws Exception;
 	
  	// 바코드로 재고 감소 실시간 조회
   	public int selectStockByBarcode(int businessId, String barcode) throws Exception;
}
