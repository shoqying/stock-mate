package com.stockm8.persistence;

import java.util.List;

import com.stockm8.domain.ShipmentVO;

public interface ShipmentDAO {
	
	// 입고 메인 오늘 들어올 리스트
		public List<ShipmentVO> todayReceivingList() throws Exception;

} // ReceivingDAO end
