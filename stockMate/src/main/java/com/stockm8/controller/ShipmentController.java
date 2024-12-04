package com.stockm8.controller;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.stockm8.service.ReceivingService;

@Controller
@RequestMapping(value = "/receiving/*")

public class ShipmentController {
	
	private static final Logger logger = LoggerFactory.getLogger(ShipmentController.class);

//	@Inject
//	private ReceivingService rService;
	
	// http://localhost:8088/receiving/main
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public void mainGET() throws Exception {
		logger.info("mainGET() »£√‚");
		
		logger.info("");
		
	}
	
	

} // ReceivingController end
