package com.stockm8.persistence;

import java.util.List;

import com.stockm8.domain.dto.QRCodeDTO;
import com.stockm8.domain.dto.StockBarcodeDTO;

public interface QRCodeDAO {
	
    public void updateQRCodePathByProductId(StockBarcodeDTO stockBarcode) throws Exception;
    
    public StockBarcodeDTO selectQRCodeByBarcode(String productBarcode) throws Exception;
    
	public StockBarcodeDTO selectQRCodeByProductId(Integer productId) throws Exception;

    // 비즈니스 ID에 속하는 상품들의 QR 코드 경로 가져오기
    List<QRCodeDTO> selectQRCodePathsByBusinessId(int businessId) throws Exception;
}
