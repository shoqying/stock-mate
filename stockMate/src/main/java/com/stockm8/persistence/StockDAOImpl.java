package com.stockm8.persistence;

import com.stockm8.domain.vo.CategoryVO;
import com.stockm8.domain.vo.StockVO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

@Repository
public class StockDAOImpl implements StockDAO {

    @Inject
    private SqlSession sqlSession;

    private static final String NAMESPACE = "com.stockm8.mapper.StockMapper.";

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
}