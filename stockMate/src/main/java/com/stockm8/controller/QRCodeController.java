package com.stockm8.controller;

import java.nio.file.Path;
import java.nio.file.Paths;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.stockm8.domain.dto.QRCodeDTO;
import com.stockm8.domain.vo.ProductVO;
import com.stockm8.service.ProductService;
import com.stockm8.service.QRCodeService;

@RestController
@RequestMapping("/api/qrcode")
public class QRCodeController {
	
    private static final Logger logger = LoggerFactory.getLogger(QRCodeController.class);

    @Autowired
    QRCodeService qrCodeService;
    
    @Autowired
    ProductService productService;

    // QRCodeService 주입
    public QRCodeController(QRCodeService qrCodeService) {
        this.qrCodeService = qrCodeService;
    }

    /**
     * QR 코드 생성 요청 처리
     * @param qrCode QRCodeDTO 객체 (상품 ID, JSON 여부 등)
     * @return 성공 또는 실패 메시지를 JSON 형태로 반환
     */
    @PostMapping("/generate")
    public ResponseEntity<String> generateQRCode(@RequestBody QRCodeDTO qrCode) {
        logger.info("Product ID: " + qrCode.getProductId()); // 디버깅: productId 값 확인
        logger.info("Is JSON QR Code: " + qrCode.getIsJsonQRCode()); // 디버깅: isJsonQRCode 확인

        try {
            // QR 코드 생성 처리
            qrCodeService.generateQRCode(qrCode.getProductId(), qrCode.getIsJsonQRCode());
            // 성공 메시지 반환
            return ResponseEntity.ok("QR 코드가 성공적으로 생성되었습니다.");
        } catch (Exception e) {
            // 실패 메시지 반환
            logger.error("QR 코드 생성 중 오류 발생", e);
            return ResponseEntity.status(500).body("QR 코드 생성 실패: " + e.getMessage());
        }
    }

    /**
     * QR 코드 다운로드 처리
     * @param productId 상품 ID
     * @return QR 코드 이미지 파일
     */
    @GetMapping("/download")
    public ResponseEntity<Resource> downloadQRCode(@RequestParam("productId") int productId) {
        try {
            // 상품 정보를 가져와 QR 코드 경로 확인
            ProductVO product = productService.getProductByID(productId); // 상품 정보를 가져오는 메서드 호출
            String qrCodePath = product.getQrCodePath();  // QR 코드 경로 확인

            if (qrCodePath == null) {
                return ResponseEntity.status(404).body(null); // QR 코드가 없으면 404 응답
            }

            Path filePath = Paths.get(qrCodePath);
            Resource resource = new UrlResource(filePath.toUri());

            if (!resource.exists()) {
                return ResponseEntity.notFound().build();
            }

            // QR 코드 파일 반환
            return ResponseEntity.ok()
                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + filePath.getFileName() + "\"")
                    .body(resource);

        } catch (Exception e) {
            return ResponseEntity.status(500).body(null);
        }
    }
}