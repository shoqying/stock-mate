package com.stockm8.service;

import java.io.IOException;

import com.stockm8.domain.vo.ProductVO;

public interface QRCodeService {
	
    // QR 코드 생성의 전체 흐름
	public void generateQRCode(int productId, boolean isJsonQRCode) throws Exception;
    
    // QR 코드 데이터 생성
    public String createQRContent(int productId) throws Exception;
    
    // QR 코드 경로 생성
    public String createQRCodePath(ProductVO product, boolean isJsonQRCode) throws Exception;
    
    // QR 코드 이미지 생성
    public void generateQRCodeImage(String qrContent, String qrCodePath) throws Exception;
}
