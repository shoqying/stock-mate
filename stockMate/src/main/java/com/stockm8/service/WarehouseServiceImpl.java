package com.stockm8.service;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.stockm8.domain.WarehouseVO;
import com.stockm8.persistence.WarehouseDAO;

@Service
public class WarehouseServiceImpl implements WarehouseService {
	
	private static final Logger logger = LoggerFactory.getLogger(WarehouseServiceImpl.class);

	@Inject
	private WarehouseDAO wdao;
	
	@Override
	public void createWarehouse(WarehouseVO wVO) throws Exception {
		
		logger.info("createWarehouse(WarehouseVO wVO) 호출");
		
		logger.info("Service -> DAO 메서드 호출");
		wdao.insertWarehouse(wVO);
	}

}