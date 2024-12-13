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
import com.stockm8.domain.vo.QRCodeVO;
import com.stockm8.service.ProductService;
import com.stockm8.service.QRCodeService;

@RestController
@RequestMapping("/api/qrcode")
public class QRCodeController {

    private static final Logger logger = LoggerFactory.getLogger(QRCodeController.class);

    @Autowired
    private QRCodeService qrCodeService;

    @Autowired
    private ProductService productService;

    /**
     * QR 코드 생성 요청 처리
     *
     * @param qrCode QRCodeDTO 객체 (상품 ID, JSON 여부 등)
     * @return 성공 또는 실패 메시지를 JSON 형태로 반환
     */
    @PostMapping("/generate")
    public ResponseEntity<String> generateQRCode(@RequestBody QRCodeDTO qrCode) {
        logger.info("QR 코드 생성 요청: Product ID={}, Is JSON={}", qrCode.getProductId(), qrCode.getIsJsonQRCode());

        try {
            // QR 코드 생성 처리
            qrCodeService.generateQRCode(qrCode.getProductId(), qrCode.getIsJsonQRCode());
            logger.info("QR 코드 생성 성공: Product ID={}", qrCode.getProductId());
            return ResponseEntity.ok("QR 코드가 성공적으로 생성되었습니다.");
        } catch (IllegalArgumentException e) {
            logger.error("유효하지 않은 요청: {}", e.getMessage());
            return ResponseEntity.badRequest().body("잘못된 요청: " + e.getMessage());
        } catch (Exception e) {
            logger.error("QR 코드 생성 중 오류 발생", e);
            return ResponseEntity.status(500).body("QR 코드 생성 실패: 내부 서버 오류");
        }
    }

    /**
     * QR 코드 다운로드 처리
     *
     * @param productId 상품 ID
     * @return QR 코드 이미지 파일
     */
    @GetMapping("/download")
    public ResponseEntity<Resource> downloadQRCode(
            @RequestParam("productId") int productId,
            @RequestParam("isJson") boolean isJson) {
        try {
            String qrCodePath;

            if (isJson) {
                // QRCodeService를 통해 JSON QR 코드 경로 가져오기
                QRCodeVO qrCode = qrCodeService.getQRCodeByProductId(productId);
                qrCodePath = qrCode.getQrCodePath();
            } else {
                // ProductService를 통해 URL QR 코드 경로 가져오기
                ProductVO product = productService.getProductByID(productId);
                qrCodePath = product.getQrCodePath();
            }

            if (qrCodePath == null || qrCodePath.isEmpty()) {
                logger.warn("QR 코드 경로가 존재하지 않음: Product ID={}, isJson={}", productId, isJson);
                return ResponseEntity.status(404).body(null);
            }

            Path filePath = Paths.get(qrCodePath);
            Resource resource = new UrlResource(filePath.toUri());
            if (!resource.exists() || !resource.isReadable()) {
                logger.error("QR 코드 파일을 읽을 수 없음: {}", qrCodePath);
                return ResponseEntity.status(404).body(null);
            }

            return ResponseEntity.ok()
                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + filePath.getFileName() + "\"")
                    .body(resource);

        } catch (Exception e) {
        	logger.error(String.format("QR 코드 다운로드 중 오류 발생: Product ID=%d, isJson=%b", productId, isJson), e);
            return ResponseEntity.status(500).body(null);
        }
    }


}
