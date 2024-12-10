package com.stockm8.persistence;

import com.stockm8.domain.vo.BusinessVO;

public interface BusinessDAO {
	
	// 회사 등록 
	public void insertBusiness(BusinessVO business) throws Exception;

}
