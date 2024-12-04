package com.stockm8.service;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.stockm8.domain.ReceivingShipmentVO;
import com.stockm8.persistence.ReceivingDAO;

@Service
public class ReceivingServiceImpl implements ReceivingService {
	
	private static final Logger logger = LoggerFactory.getLogger(ReceivingServiceImpl.class);
	
	@Inject
	private ReceivingDAO rdao;

	// 입고 메인 오늘 들어올 리스트
	@Override
	public List<ReceivingShipmentVO> getTodayReceivingList() throws Exception {
		logger.info("getTodayReceivingList() 호출");
		return rdao.selectTodayReceivingList();
	}

	@Override
	public List<ReceivingShipmentVO> getYesterdayReceivingList() throws Exception {
		logger.info("getYesterdayReceivingList() 호출");
		return null;
	}
	
	
	
	

} // ReceivingServiceImpl end
