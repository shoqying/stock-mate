package com.stockm8.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.stockm8.domain.vo.ProductVO;
import com.stockm8.domain.vo.QRCodeVO;
import com.stockm8.persistence.CategoryDAO;
import com.stockm8.persistence.ProductDAO;
import com.stockm8.persistence.QRCodeDAO;

@Service
public class QRCodeServiceImpl implements QRCodeService {

    private static final Logger logger = LoggerFactory.getLogger(QRCodeServiceImpl.class);

    @Autowired
    private ProductDAO productDAO;

    @Autowired
    private CategoryDAO categoryDAO;

    @Autowired
    private QRCodeDAO qrCodeDAO;

    @Override
    public void generateQRCode(int productId, boolean isJsonQRCode) throws Exception {
        System.out.println("서비스 호출: Product ID = " + productId + ", Is JSON QR = " + isJsonQRCode);
        ProductVO product = productDAO.getProductById(productId);
        if (product == null) {
            throw new IllegalArgumentException("존재하지 않는 상품 ID: " + productId);
        }

        // QR 코드 데이터 결정 (URL 또는 JSON)
        String qrCodeData;
        if (isJsonQRCode) {
            qrCodeData = createJSONContent(product);
        } else {
            qrCodeData = createQRContent(productId);
        }

        // QR 코드 이미지 파일 경로 생성
        String filePath = createQRCodePath(product, isJsonQRCode);

        // QR 코드 생성 및 저장
        generateQRCodeImage(qrCodeData, filePath);

        // QRCodeVO 객체 생성
        QRCodeVO qrCode = new QRCodeVO();
        qrCode.setProductId(productId);
        qrCode.setQrCodeData(qrCodeData);
        qrCode.setQrCodePath(filePath);

        // 데이터베이스에 저장
        qrCodeDAO.insertQRCode(qrCode);
    }

    // URL QR 코드 데이터 생성
    public String createQRContent(int productId) {
        return "http://localhost:8088/product/detail?productId=" + productId;
    }

    // JSON QR 코드 데이터 생성
    public String createJSONContent(ProductVO product) {
        return String.format(
            "{\"productId\":%d,\"barcode\":\"%s\",\"businessId\":%d,\"baseUnit\":\"%s\",\"setSize\":%d}",
            product.getProductId(),
            product.getBarcode(),
            product.getBusinessId(),
            product.getBaseUnit(),
            product.getSetSize()
        );
    }

    // QR 코드 경로 생성
    public String createQRCodePath(ProductVO product, boolean isJsonQRCode) throws Exception {
        String safeProductName = product.getName().replaceAll("[\\\\/:*?\"<>|]", "_");
        String categoryName = categoryDAO.selectCategoryNameById(product.getCategoryId())
                .replaceAll("[\\\\/:*?\"<>|]", "_");

        // 기본 경로 설정
        String basePath = "/Users/Insung/Documents/products/qrcodes";
        String directoryPath;

        // QR 코드 유형에 따라 디렉토리 경로 구분
        if (isJsonQRCode) {
            directoryPath = basePath + File.separator + "json" + File.separator
                    + product.getBusinessId() + File.separator
                    + product.getCategoryId() + "_" + categoryName;
        } else {
            directoryPath = basePath + File.separator + "details" + File.separator
                    + product.getBusinessId() + File.separator
                    + product.getCategoryId() + "_" + categoryName;
        }

        // 파일 이름 생성 (JSON과 URL QR 코드 구분)
        String qrCodeFileName = product.getProductId() + "_" + safeProductName + (isJsonQRCode ? "_json" : "_detail") + ".png";
        String qrCodePath = directoryPath + File.separator + qrCodeFileName;

        // 디렉토리 생성
        File directory = new File(directoryPath);
        if (!directory.exists() && !directory.mkdirs()) {
            throw new IOException("QR 코드 디렉토리를 생성할 수 없습니다: " + directoryPath);
        }

        return qrCodePath;
    }

    // QR 코드 이미지 생성
    public void generateQRCodeImage(String qrContent, String qrCodePath) throws Exception {
        QRCodeWriter qrCodeWriter = new QRCodeWriter();
        BitMatrix bitMatrix = qrCodeWriter.encode(
            new String(qrContent.getBytes("UTF-8"), "ISO-8859-1"),
            BarcodeFormat.QR_CODE,
            200,
            200
        );
        Path path = Paths.get(qrCodePath);
        MatrixToImageWriter.writeToPath(bitMatrix, "PNG", path);
    }

}