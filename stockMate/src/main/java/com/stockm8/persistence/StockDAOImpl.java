package com.stockm8.persistence;

import com.stockm8.domain.vo.StockVO;
import com.stockm8.domain.vo.ProductVO;
import com.stockm8.domain.vo.WarehouseVO;
import com.stockm8.domain.vo.CategoryVO;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import javax.inject.Inject;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class StockDAOImpl implements StockDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(StockDAOImpl.class);

    @Inject
    private SqlSession sqlSession;

    private static final String NAMESPACE = "com.stockm8.mapper.stockMapper.";

    @Override
    public List<StockVO> selectAllStockByBusinessId(int businessId) throws Exception {
        return sqlSession.selectList(NAMESPACE + "selectAllStockByBusinessId", businessId);
    }

    @Override
    public ProductVO selectProductById(int productId) throws Exception {
        return sqlSession.selectOne(NAMESPACE + "selectProductById", productId);
    }

    @Override
    public List<StockVO> selectFilteredStocks(String warehouseName, String categoryName, String sortOrder) throws Exception {
        // 파라미터를 Map으로 감싸서 전달
        Map<String, Object> params = new HashMap<>();
        params.put("warehouseName", warehouseName);
        params.put("categoryName", categoryName);
        params.put("sortOrder", sortOrder);


        // 필터링 조건에 맞는 재고 목록을 조회하는 SQL 쿼리 호출
        return sqlSession.selectList(NAMESPACE + "selectFilteredStocks", params);
    }

    @Override
    public List<WarehouseVO> selectAllWarehouses() throws Exception {
        return sqlSession.selectList(NAMESPACE + "selectAllWarehouses");
    }

    @Override
    public List<CategoryVO> selectAllCategories() throws Exception {
        return sqlSession.selectList(NAMESPACE + "selectAllCategories");
    }

	@Override
	public List<StockVO> selectQuantityCheckByBarcode(int businessId, String barcode) throws Exception {
		logger.info("selectReceiving() 호출");
		Map<String, Object> paramMap = new HashMap();
		paramMap.put("businessId", businessId);	   
		paramMap.put("barcode", barcode);
		
		return sqlSession.selectList(NAMESPACE + "selectQuantityCheckByBarcode", paramMap);
	}

	@Override
	public int updateIncreseStock(int businessId, String barcode) throws Exception {
		logger.info("updateDecreaseStock() 호출");
	    // 매개변수 묶기
	    Map<String, Object> params = new HashMap<>();
	    params.put("businessId", businessId);
	    params.put("barcode", barcode);

	    // SQL 실행
	    return sqlSession.update(NAMESPACE + "updateIncreseStock", params);
	}

	@Override
	public int selectStockByBarcode(int businessId, String barcode) throws Exception {
		logger.info("selectStockByBarcode() 호출");
		Map<String, Object> params = new HashMap<>();
	    params.put("businessId", businessId);
	    params.put("barcode", barcode);
		return sqlSession.selectOne(NAMESPACE + "selectStockByBarcode", params);
	}
	
	
	
	

	
    
    
}
