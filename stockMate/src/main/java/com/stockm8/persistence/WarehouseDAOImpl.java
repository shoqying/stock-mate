package com.stockm8.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.stockm8.domain.vo.WarehouseVO;

@Repository
public class WarehouseDAOImpl implements WarehouseDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(WarehouseDAOImpl.class);
	
	// 디비연결 객체 주입 
	private SqlSession sqlSession;
	
	private static final String NAMESPACE = "com.stockm8.mappers.warehouseMapper.";

	@Override
	public void insertWarehouse(WarehouseVO wVO) throws Exception {
		logger.info("insertWarehouse(WarehouseVO wVO) 호출");
		sqlSession.insert(NAMESPACE + "insertWarehouse", wVO);
	}

	@Override
	public List<WarehouseVO> selectWarehousesByBusinessId(Long businessId) throws Exception {
		logger.info("getWarehousesByBusinessId(Long businessId) 호출");

		return sqlSession.selectList(NAMESPACE + "selectWarehousesByBusinessId", businessId);
	}

	
}
