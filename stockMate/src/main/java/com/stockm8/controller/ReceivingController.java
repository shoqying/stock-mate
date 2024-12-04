package com.stockm8.controller;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.stockm8.domain.ReceivingVO;
import com.stockm8.persistence.ReceivingDAO;
import com.stockm8.service.ReceivingService;

@Controller
@RequestMapping(value = "/receiving/*")
public class ReceivingController {
	
	private static final Logger logger = LoggerFactory.getLogger(ReceivingController.class);

	@Inject
	private ReceivingService rService;
	
	// http://localhost:8088/receiving/main
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public void mainGET(Model model, ReceivingVO vo) throws Exception {
		logger.info("mainGET() 호출");
		
		List<ReceivingVO> todayReceivingList = rService.getTodayReceivingList();
		logger.info(todayReceivingList.size() + "개");
		
		model.addAttribute("todayReceivingList", todayReceivingList);
		
	}
	
	
	
	

} // ReceivingController end
