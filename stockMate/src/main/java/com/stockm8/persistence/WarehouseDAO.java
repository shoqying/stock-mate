package com.stockm8.persistence;

import com.stockm8.domain.vo.WarehouseVO;

public interface WarehouseDAO {

	// 창고 등록 
	public void insertWarehouse(WarehouseVO wVO) throws Exception;
}
