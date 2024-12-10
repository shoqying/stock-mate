package com.stockm8.service;

import com.stockm8.domain.vo.BusinessVO;

public interface BusinessService {
	
	// 회사 등록 
	public void registerBusiness(BusinessVO business) throws Exception;
	
}
