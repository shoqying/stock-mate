package com.stockm8.service;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.stockm8.domain.vo.Criteria;
import com.stockm8.domain.vo.ProductVO;
import com.stockm8.domain.vo.ReceivingShipmentVO;
import com.stockm8.domain.vo.StockVO;
import com.stockm8.persistence.ShipmentDAO;

@Service
public class ShipmentServiceImpl implements ShipmentService {
	
	private static final Logger logger = LoggerFactory.getLogger(ShipmentServiceImpl.class);
	
	@Inject
	private ShipmentDAO sdao;
	

	// 메인 입고 리스트
	@Override
	public List<ReceivingShipmentVO> getShipmentList(int businessId) throws Exception {
		logger.info("getTodayShipmentList() 호출");
		return sdao.selectShipmentList(businessId);
	}

	@Override
	public List<ReceivingShipmentVO> getYesterdayShipmentList(int businessId) throws Exception {
		logger.info("getYesterdayShipmentList() 호출");
		return sdao.selectYesterdayShipmentList(businessId);
	}

	@Override
	public List<ReceivingShipmentVO> getTDBYShipmentList(int businessId) throws Exception {
		logger.info("getTDBYShipmentList() 호출");
		return sdao.selectTDBYShipmentList(businessId);
	}

	@Override
	public List<ReceivingShipmentVO> getShipmentHistoryList(Criteria cri, int businessId) throws Exception {
		logger.info("getShipmentHistoryList() 호출");
		return sdao.selectShipmentHistoryList(cri, businessId);
	}
	
	@Override
	public List<ReceivingShipmentVO> getHistoryByDateRange(String startDate, String endDate, String keyword, Criteria cri, int businessId) throws Exception{
		logger.info("getHistoryByDateRange() 호출");
	    return sdao.selectHistoryByDateRange(startDate, endDate, keyword, cri, businessId);
	}
	
	@Override
	public int getTotalCountBySearch(String startDate, String endDate, String keyword, int businessId) throws Exception {
		logger.info("getTotalCountBySearch() 호출");
		return sdao.selectTotalCountBySearch(startDate, endDate, keyword, businessId);
	}

	@Override
	public int getTotalCount(int businessId) throws Exception {
		logger.info("getTotalCount() 호출");
		return sdao.selectTotalCount(businessId);
	}

	@Override
	public void insertShipment(int businessId) throws Exception {
		logger.info("insertShipment() 호출");
		sdao.insertShipment(businessId);
	}

	
	@Transactional
	@Override
	public int increseStockByBarcode(int businessId, String barcode) throws Exception {
		logger.info("increseStockByBarcode() 호출");
        List<StockVO> stock = sdao.selectQuantityCheckByBarcode(businessId, barcode);
        if (stock == null) {
            return -1; // 유효하지 않은 바코드
        }
        
        int updatedRows = sdao.updateIncreseStock(businessId, barcode);
        if (updatedRows > 0) {
            return sdao.selectStockByBarcode(businessId, barcode); // 증가 후 남은 재고 반환
        } else {
            throw new RuntimeException("재고 업데이트 실패");
        }
    }

	@Override
	public int decreaseReservedQuantity(int businessId, String barcode) throws Exception {
		logger.info("decreaseReservedQuantity() 호출");
		
		return sdao.selectReservedQuantity(businessId, barcode);
	}

	@Override
	public ProductVO productNameBarcode(int businessId, String barcode) throws Exception {
		logger.info("productNameBarcode() 호출");
		
		return sdao.selectProductNameBarcode(businessId, barcode);
	}
	
	@Override
	public void ShipmentStatusToComplete(int businessId, String barcode) {
	    try {
	        // MyBatis 매퍼 호출
	        sdao.updateShipmentStatusToComplete(businessId, barcode);
	    } catch (Exception e) {
	        // 예외 처리
	        logger.error("입고 상태 업데이트 오류: " + e.getMessage());
	    }
	}
	
	
	
	



} // ShipmentServiceImpl end