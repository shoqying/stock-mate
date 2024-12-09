package com.stockm8.service;

import java.util.List;

import com.stockm8.domain.vo.ReceivingShipmentVO;


public interface ReceivingService {
	
	// 메인 입고 리스트
	public List<ReceivingShipmentVO> getReceivingList() throws Exception;
	
	// 메인 어제 입고 리스트
	public List<ReceivingShipmentVO> getYesterdayReceivingList() throws Exception;
	
	// 메인 그제 입고 리스트
	public List<ReceivingShipmentVO> getTDBYReceivingList() throws Exception;
	
	// 입고 내역 리스트
	public List<ReceivingShipmentVO> getReceivingHistoryList() throws Exception;
	
	// 입고 내역 검색
	public List<ReceivingShipmentVO> getHistoryByDateRange(String startDate, String endDate, String keyword) throws Exception;
	
	

} // ReceivingService end