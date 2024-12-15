package com.stockm8.persistence;

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

    @Override
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
    

}
