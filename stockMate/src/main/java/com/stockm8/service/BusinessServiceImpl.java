package com.stockm8.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.stockm8.domain.vo.BusinessVO;
import com.stockm8.persistence.BusinessDAO;

@Service
public class BusinessServiceImpl implements BusinessService {
	
	private static final Logger logger = LoggerFactory.getLogger(BusinessServiceImpl.class);
 
	@Autowired
	BusinessDAO businessDAO;
	
	@Override
	public void registerBusiness(BusinessVO business) throws Exception {
	    logger.info("registerBusiness() 호출");
	    
	    // DAO를 통해 상품 등록
	    businessDAO.insertBusiness(business);
	}

}
