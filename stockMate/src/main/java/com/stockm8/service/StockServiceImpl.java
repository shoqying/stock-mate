package com.stockm8.service;

import com.stockm8.domain.vo.StockVO;
import com.stockm8.domain.vo.WarehouseVO;
import com.stockm8.persistence.FilterCriteria;
import com.stockm8.domain.vo.CategoryVO;
import com.stockm8.persistence.StockDAO;
import com.stockm8.persistence.WarehouseDAO;
import com.stockm8.persistence.CategoryDAO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.stockm8.domain.vo.CategoryVO;
import com.stockm8.domain.vo.ProductVO;
import com.stockm8.domain.vo.StockVO;
import com.stockm8.persistence.CategoryDAO;
import com.stockm8.persistence.StockDAO;

@Service
public class StockServiceImpl implements StockService {

    @Inject
    private StockDAO stockDAO;
    
    @Autowired
    private CategoryDAO categoryDAO;
    
    // 재고 등록
    @Override
	public void registerStock(StockVO stock) throws Exception {
    	stockDAO.insertStock(stock);
	}


    @Inject
    private WarehouseDAO warehouseDAO;

	// 사업자 ID에 해당하는 재고 목록 조회
    @Override
    public List<StockVO> getStockListByBusinessId(int businessId) throws Exception {
        return stockDAO.selectOnlyStockByBusinessId(businessId);
    }

    // 상품 ID로 상품 상세 조회
    @Override
    public ProductVO getProductById(int productId) throws Exception {
        return stockDAO.selectProductById(productId);
    }

    @Inject
    private CategoryDAO categoryDAO;

    // 사업자 ID에 해당하는 창고 목록 조회
    @Override
    public List<WarehouseVO> getWarehousesByBusinessId(int businessId) throws Exception {
        return warehouseDAO.selectWarehousesByBusinessId(businessId);
    }
    
    public Map<String, Object> getStockAndCategories(int businessId) throws Exception {
        // 재고 목록 조회
        List<StockVO> stockList = stockDAO.selectStockListByBusinessId(businessId);

    // 필터링된 재고 목록 조회
    @Override
    public List<StockVO> getStockList(FilterCriteria criteria, String sortOrder) throws Exception {
        // sortOrder를 전달하여 정렬 기준을 처리
        return stockDAO.selectFilteredStocks(criteria, sortOrder);  // StockDAO에서 필터링된 재고 목록 조회
    }

    // 카테고리 목록 조회
    @Override
    public List<CategoryVO> getCategoryList() throws Exception {
        return categoryDAO.selectAllCategories();  // CategoryDAO에서 카테고리 목록 조회
    }
}

        // 카테고리 목록은 CategoryService를 통해 가져오기
        List<CategoryVO> categoryList = categoryDAO.selectCategoriesByBusinessId(businessId);

        // 결과를 Map에 담아서 반환
        Map<String, Object> result = new HashMap<>();
        result.put("stockList", stockList);
        result.put("categoryList", categoryList);

        return result;
    }
    
}

