package com.stockm8.service;

import java.util.List;

import com.stockm8.domain.ReceivingVO;

public interface ReceivingService {
	
	// 입고 메인 오늘 들어올 리스트
	public List<ReceivingVO> getTodayReceivingList() throws Exception;
	
	// 입고 메인 어제 들어온 리스트
	public List<ReceivingVO> getYesterdayReceivingList() throws Exception;

} // ReceivingService end
