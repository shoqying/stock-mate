package com.stockm8.service;

import com.stockm8.domain.WarehouseVO;

public interface WarehouseService {
	
	// 창고 등록 
	public void createWarehouse(WarehouseVO wVO) throws Exception;
	
}
