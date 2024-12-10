package com.stockm8.persistence;

import com.stockm8.domain.vo.StockVO;
import com.stockm8.domain.vo.ProductVO;
import com.stockm8.domain.vo.WarehouseVO;
import com.stockm8.domain.vo.CategoryVO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import javax.inject.Inject;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class StockDAOImpl implements StockDAO {

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
}
