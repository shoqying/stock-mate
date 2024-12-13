package com.stockm8.persistence;

import com.stockm8.domain.vo.QRCodeVO;

public interface QRCodeDAO {
	
    public void insertQRCode(QRCodeVO qrCode);
    
    public QRCodeVO selectQRCodeByProductId(int productId);
    
}
