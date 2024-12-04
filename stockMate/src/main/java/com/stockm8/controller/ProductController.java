package com.stockm8.controller;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.stockm8.service.ProductService;

@Controller
@RequestMapping(value = "/product/*") // 공통 URI 주소 
public class ProductController {
	
	private static final Logger logger = LoggerFactory.getLogger(ProductController.class);
	
	@Inject
	private ProductService pService;
	
	// http://localhost:8088/product/create
	@RequestMapping(value = "/create", method = RequestMethod.GET)
	public void registGET() throws Exception {
		logger.info("/product/create 호출");
		logger.info("연결된 뷰페이지(/board/create.jsp) 이동");
	}
	
	 
	
}
