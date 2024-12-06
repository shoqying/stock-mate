package com.stockm8.persistence;

import java.util.List;

import com.stockm8.domain.vo.WarehouseVO;

public interface WarehouseDAO {

	// 창고 등록 
	public void insertWarehouse(WarehouseVO wVO) throws Exception;
	
	// 회사정보를 통한 창고ID 조회
	List<WarehouseVO> selectWarehousesByBusinessId(Long businessId) throws Exception;
	
}
