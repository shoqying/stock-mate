package com.stockm8.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.stockm8.domain.vo.CategoryVO;

@Repository
public class CategoryDAOImpl implements CategoryDAO {

    @Inject
    private SqlSession sqlSession;

    private static final String NAMESPACE
    				  = "com.stockm8.mapper.CategoryMapper";

    @Override
    public void insertCategory(CategoryVO vo) throws Exception {
    	
    	// mapper SQL 구문 호출
        sqlSession.insert(NAMESPACE + ".insertCategory", vo);
    }

    @Override
    public List<CategoryVO> selectAllCategories() throws Exception {
    	
    	// mapper SQL 구문 호출
        return sqlSession.selectList(NAMESPACE + ".selectAllCategories"); 
    }
}
