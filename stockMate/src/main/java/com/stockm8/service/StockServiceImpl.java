package com.stockm8.service;

import com.stockm8.domain.vo.StockVO;
import com.stockm8.domain.vo.WarehouseVO;
import com.stockm8.persistence.FilterCriteria;
import com.stockm8.domain.vo.CategoryVO;
import com.stockm8.persistence.StockDAO;
import com.stockm8.persistence.WarehouseDAO;
import com.stockm8.persistence.CategoryDAO;

import javax.inject.Inject;
import java.util.List;

import org.springframework.stereotype.Service;

@Service
public class StockServiceImpl implements StockService {

    @Inject
    private StockDAO stockDAO;

    @Inject
    private WarehouseDAO warehouseDAO;

    @Inject
    private CategoryDAO categoryDAO;

    // 사업자 ID에 해당하는 창고 목록 조회
    @Override
    public List<WarehouseVO> getWarehousesByBusinessId(int businessId) throws Exception {
        return warehouseDAO.selectWarehousesByBusinessId(businessId);
    }

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