package com.stockm8.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.stockm8.domain.dto.QRCodeDTO;
import com.stockm8.domain.vo.ProductVO;
import com.stockm8.domain.vo.QRCodeVO;
import com.stockm8.exceptions.QRCodeGenerationException;
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
     * 비동기 방식으로 QR 코드 생성 요청 처리
     * 
     * @param productId 생성할 상품 ID
     * @return 즉시 처리 시작 메시지 반환
     * @throws Exception 
     * @throws UnsupportedEncodingException 
     */
    @PostMapping("/generate")
    @ResponseBody
    public ResponseEntity<Map<String, String>> generateQRCode(@RequestBody QRCodeDTO qrCodeDTO) throws Exception {
        Map<String, String> response = new HashMap<>();
        try {
            qrCodeService.generateQRCode(qrCodeDTO.getProductId());
            response.put("status", "success");
            response.put("message", "QR 코드가 성공적으로 생성되었습니다!");
            return ResponseEntity.ok(response);
        } catch (QRCodeGenerationException e) {
            response.put("status", "error");
            response.put("message", "QR 코드 생성 중 오류가 발생했습니다: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }

    /**
     * JSON QR 코드 다운로드 처리
     * JSON 형식의 QR 코드만 다운로드하도록 수정
     *
     * @param productId 상품 ID
     * @return QR 코드 이미지 파일 (JSON QR 코드만)
     */
    @PostMapping("/download")
    public ResponseEntity<Resource> downloadQRCode(@RequestBody QRCodeDTO qrCodeDTO) throws Exception {
        if (qrCodeDTO.getProductId() <= 0) {
            throw new IllegalArgumentException("유효하지 않은 상품 ID입니다.");
        }
        
	    // 상품 정보 가져오기
	    ProductVO product = productService.getProductByID(qrCodeDTO.getProductId());

        // QR 코드 정보 가져오기
        QRCodeVO qrCode = qrCodeService.getQRCodeByProductId(qrCodeDTO.getProductId());
        if (qrCode == null || qrCode.getQrCodePath() == null) {
            throw new IllegalArgumentException("QR 코드가 존재하지 않습니다.");
        }

        // QR 코드 파일 확인
        File qrCodeFile = new File(qrCode.getQrCodePath());
        if (!qrCodeFile.exists()) {
            throw new IllegalArgumentException("QR 코드 파일이 존재하지 않습니다.");
        }

        // QR 코드 파일 이름 생성 (서버에서 사용하는 동일한 형식 적용)
        String safeProductName = product.getName().replaceAll("[\\\\/:*?\"<>|]", "_");
        String qrCodeFileName = qrCode.getProductId() + "_scan_" + safeProductName + ".png";

        // 파일명 인코딩 (다운로드 파일 이름에 반영)
        String encodedFileName = URLEncoder.encode(qrCodeFileName, "UTF-8").replace("+", "%20");
        Resource resource = new FileSystemResource(qrCodeFile);
        
        // Content-Disposition 헤더 설정
        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename*=UTF-8''" + encodedFileName) // UTF-8 호환
                .contentType(MediaType.APPLICATION_OCTET_STREAM)
                .contentLength(qrCodeFile.length())
                .body(resource);
    }
    

}