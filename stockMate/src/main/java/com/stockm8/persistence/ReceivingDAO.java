package com.stockm8.persistence;

import java.util.List;

import com.stockm8.domain.ReceivingVO;

public interface ReceivingDAO {
	
	// 입고 메인 오늘 들어올 리스트
	public List<ReceivingVO> selectTodayReceivingList() throws Exception;

} // ReceivingDAO end
