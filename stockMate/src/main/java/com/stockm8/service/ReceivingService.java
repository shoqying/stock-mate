package com.stockm8.service;

import java.util.List;

import com.stockm8.domain.ReceivingShipmentVO;


public interface ReceivingService {
	
	// 입고 메인 오늘 들어올 리스트
	public List<ReceivingShipmentVO> getTodayReceivingList() throws Exception;
	
	// 입고 메인 어제 들어온 리스트
	public List<ReceivingShipmentVO> getYesterdayReceivingList() throws Exception;

} // ReceivingService end
