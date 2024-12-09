package com.stockm8.service;

import com.stockm8.domain.vo.CategoryVO;
import com.stockm8.domain.vo.ProductVO;
import com.stockm8.domain.vo.StockVO;
import com.stockm8.domain.vo.WarehouseVO;
import com.stockm8.persistence.StockDAO;

import javax.inject.Inject;
import java.util.List;

import org.springframework.stereotype.Service;

@Service
public class StockServiceImpl implements StockService {

    @Inject
    private StockDAO stockDAO;

    // 사업자 ID에 해당하는 재고 목록 조회
    @Override
    public List<StockVO> getAllStock(int businessId) throws Exception {
        return stockDAO.selectAllStockByBusinessId(businessId);
    }

    // 상품 ID로 상품 상세 조회
    @Override
    public ProductVO getProductById(int productId) throws Exception {
        return stockDAO.selectProductById(productId);
    }

    // 사용 가능한 재고 자동 계산 (서비스 계층에서 직접 계산)
    @Override
    public int calculateAvailableStock(StockVO stock) throws Exception {
        // totalQuantity - reservedQuantity 계산
        return stock.getTotalQuantity() - stock.getReservedQuantity();
    }

    @Override
    public List<StockVO> filterStocks(String warehouseName, String categoryName, String sortOrder) throws Exception {
        return stockDAO.selectFilteredStocks(warehouseName, categoryName, sortOrder);
    }

    // 창고 목록 조회
    @Override
    public List<WarehouseVO> getAllWarehouses() throws Exception {
        return stockDAO.selectAllWarehouses();
    }

    // 카테고리 목록 조회
    @Override
    public List<CategoryVO> getAllCategories() throws Exception {
        return stockDAO.selectAllCategories();
    }
}
