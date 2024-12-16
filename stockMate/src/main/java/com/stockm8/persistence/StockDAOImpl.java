package com.stockm8.persistence;

import com.stockm8.domain.vo.StockVO;
import com.stockm8.domain.vo.ProductVO;
import com.stockm8.domain.vo.WarehouseVO;
import com.stockm8.domain.vo.CategoryVO;
import com.stockm8.domain.vo.StockVO;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import javax.inject.Inject;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;


import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import com.stockm8.domain.vo.ProductVO;
import com.stockm8.domain.vo.StockVO;

@Repository
public class StockDAOImpl implements StockDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(StockDAOImpl.class);

    @Inject
    private SqlSession sqlSession;

    private static final String NAMESPACE = "com.stockm8.mapper.StockMapper.";
    
    // 재고 등록
    @Override
	public void insertStock(StockVO stock) throws Exception {
        sqlSession.insert(NAMESPACE + "insertStock", stock);
	}

	@Override
    public List<StockVO> selectStockListByBusinessId(int businessId) throws Exception {
        return sqlSession.selectList(NAMESPACE + "selectStockListByBusinessId", businessId);
    }


    // 필터링된 재고 목록 조회 (정렬 기준 포함)
    @Override
    public List<StockVO> selectFilteredStocks(FilterCriteria criteria, String sortOrder) throws Exception {
        // 파라미터를 Map으로 묶어서 MyBatis 쿼리로 전달
        Map<String, Object> params = new HashMap<>();
        params.put("criteria", criteria);
        params.put("sortOrder", sortOrder);  // 정렬 기준 추가

        // MyBatis 매퍼에 정의된 SQL 쿼리 호출
        return sqlSession.selectList(NAMESPACE + "selectFilteredStocks", params);
    }

    // 카테고리 목록 조회
    @Override
    public List<CategoryVO> selectCategoryList() throws Exception {
        return sqlSession.selectList(NAMESPACE + "selectCategoryList");  // CategoryDAO에서 카테고리 목록 조회
    }
    
    public ProductVO selectProductById(int productId) throws Exception {
        return sqlSession.selectOne(NAMESPACE + "selectProductById", productId);
    }

    @Override
    public List<StockVO> selectFilteredStocks(String warehouseName, String categoryName, String sortOrder) throws Exception {
        Map<String, Object> params = new HashMap<>();
        if (warehouseName != null && !warehouseName.isEmpty()) {
            params.put("warehouseName", warehouseName);
        }
        if (categoryName != null && !categoryName.isEmpty()) {
            params.put("categoryName", categoryName);
        }
        params.put("sortOrder", sortOrder);

        return sqlSession.selectList(NAMESPACE + "selectFilteredStocks", params);
    }

	@Override
	public List<StockVO> selectOnlyStockByBusinessId(int businessId) throws Exception {
        return sqlSession.selectList(NAMESPACE + "selectOnlyStockByBusinessId", businessId);
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

