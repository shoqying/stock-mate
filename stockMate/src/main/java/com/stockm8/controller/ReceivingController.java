package com.stockm8.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.redirectedUrl;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.stockm8.domain.vo.ReceivingShipmentVO;
import com.stockm8.service.ReceivingService;

@Controller
@RequestMapping(value = "/receiving/*")
public class ReceivingController {
	
	private static final Logger logger = LoggerFactory.getLogger(ReceivingController.class);

	@Inject
	private ReceivingService rService;
	
	// http://localhost:8088/receiving/main
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public void mainGET(Model model) throws Exception {
		logger.info("mainGET() 호출");
		
		List<ReceivingShipmentVO> ReceivingList = rService.getReceivingList();
		logger.info(ReceivingList.size() + "개");
		
		List<ReceivingShipmentVO> YesterdayReceivingList = rService.getYesterdayReceivingList();
		logger.info(YesterdayReceivingList.size() + "개");
		
		List<ReceivingShipmentVO> TDBYReceivingList = rService.getTDBYReceivingList();
		logger.info(TDBYReceivingList.size() + "개");
		
		model.addAttribute("ReceivingList", ReceivingList);
		model.addAttribute("YesterdayReceivingList", YesterdayReceivingList);
		model.addAttribute("TDBYReceivingList", TDBYReceivingList);
		
	}
	
	@RequestMapping(value = "/history", method = RequestMethod.GET)
	public void historyGET(@RequestParam(value = "startDate", required = false) String startDate,
	                       @RequestParam(value = "endDate", required = false) String endDate,
	                       @RequestParam(value = "keyword", required = false) String keyword,
	                       Model model) throws Exception {
	    logger.info("historyGET() 호출");

	    List<ReceivingShipmentVO> ReceivingList;

	    // 날짜와 키워드가 모두 있는 경우
	    if (startDate != null && endDate != null && keyword != null) {
	        logger.info("기간별 검색 및 키워드 검색: 시작 날짜 - " + startDate + ", 종료 날짜 - " + endDate + ", 키워드 - " + keyword);
	        ReceivingList = rService.getHistoryByDateRange(startDate, endDate, keyword);
	    } 
	    // 날짜가 없고 키워드만 있는 경우
	    else if (keyword != null) {
	        logger.info("키워드만 검색: 키워드 - " + keyword);
	        ReceivingList = rService.getHistoryByDateRange(null, null, keyword);
	    } 
	    // 날짜만 있는 경우
	    else if (startDate != null && endDate != null) {
	        logger.info("기간별 검색: 시작 날짜 - " + startDate + ", 종료 날짜 - " + endDate);
	        ReceivingList = rService.getHistoryByDateRange(startDate, endDate, null);
	    }
	    // 둘 다 없을 경우 전체 조회
	    else {
	        logger.info("전체 조회");
	        ReceivingList = rService.getReceivingHistoryList();
	    }

	    logger.info(ReceivingList.size() + "개");
	    model.addAttribute("ReceivingList", ReceivingList);
	}
	
	
	   

	

} // ReceivingController end
