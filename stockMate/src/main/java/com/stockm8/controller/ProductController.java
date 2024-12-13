package com.stockm8.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.stockm8.domain.vo.CategoryVO;
import com.stockm8.domain.vo.ProductVO;
import com.stockm8.domain.vo.UserVO;
import com.stockm8.service.CategoryService;
import com.stockm8.service.ProductService;
import com.stockm8.service.UserService;

@Controller
@RequestMapping(value = "/product/*") // 공통 URI 주소
public class ProductController {

	private static final Logger logger = LoggerFactory.getLogger(ProductController.class);

	@Autowired
	private ProductService productService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private CategoryService categoryService;

	// http://localhost:8088/product/register
	// 상품 등록 페이지
	@GetMapping("/register")
	public String registGET(Model model, HttpServletRequest request) throws Exception {
		logger.info("registGET() 호출");
		
	    // 세션에서 userId 가져오기
	    HttpSession session = request.getSession(false);
	    Long userId = (session != null) ? (Long)session.getAttribute("userId") : null;
        
	    // userId로 사용자 정보 조회
	    UserVO user = userService.getUserById(userId);
	    int businessId = user.getBusinessId();
	    
        // DB에서 카테고리 정보 가져오기
        List<CategoryVO> categoryList = categoryService.getCategoriesByBusinessId(businessId);

        // 모델에 데이터 추가
        model.addAttribute("categoryList", categoryList);

        // 창고 정보와 카테고리 정보가 없으면 추가 버튼 표시를 위한 플래그 설정
        model.addAttribute("hasCategories", !categoryList.isEmpty());

		logger.info("연결된 뷰페이지(/product/register.jsp) 이동");
		return "product/register"; // 상품 등록 페이지로 이동
	}

	// 상품 등록 처리
	@PostMapping("/register")
	public String registPOST(ProductVO product, 
							 HttpServletRequest request, 
							 RedirectAttributes rttr) throws Exception {
		logger.info("registPOST() 호출");

		// 전달정보(파라미터) 확인
		logger.info("product: {}", product);
	    
		// 세션에서 userId 가져오기 
		HttpSession session = request.getSession(false);
		Long userId = (session != null) ? (Long)session.getAttribute("userId") : null;
		
        // userId로 사용자 정보 조회
        UserVO user = userService.getUserById(userId);
        
        // user의 businessId 설정
        product.setBusinessId(user.getBusinessId());
				
		// DB등록처리 / Service -> DAO -> mapper(sql 호출) 
		productService.registerProduct(product);
		
		// DB insert 후 생성된 productId PK
		int productId = product.getProductId();
		

//	    // QR 코드 생성
//	    try {
//	        productService.generateQRCode(productId);
//	        rttr.addFlashAttribute("successMessage", "QR 코드가 성공적으로 생성되었습니다! 상품 ID: " + productId);
//	    } catch (Exception e) {
//	        logger.error("QR 코드 생성 중 오류 발생: productId={}", productId, e);
//	        rttr.addFlashAttribute("errorMessage", "QR 코드 생성 중 문제가 발생했습니다.");
//	    }
		
		logger.info("연결된 뷰페이지(/product/detail.jsp) 이동");
		return "redirect:/product/detail?productId=" + productId;
	}
	
	// QR코드 등록 처리
	@GetMapping("/generateQR")
	public String generateQR(@RequestParam("productId") int productId, RedirectAttributes rttr) throws Exception {
	    logger.info("generateQR() 호출");
	    logger.info("전송된 productId: {}", productId);

	    if (productId == 0) {
	        rttr.addFlashAttribute("errorMessage", "유효한 상품 ID가 필요합니다.");
	        return "redirect:/product/detail?productId=" + productId;
	    }
	    
	    // 상품 정보 가져오기
	    ProductVO product = productService.getProductByID(productId);
	    if (product == null) {
	        rttr.addFlashAttribute("errorMessage", "상품 정보를 찾을 수 없습니다.");
	        return "redirect:/product/detail?productId=" + productId;
	    }

	    // QR 코드 생성 (예외 발생 시 @ControllerAdvice에서 처리)
	    productService.generateQRCode(productId);
	    rttr.addFlashAttribute("successMessage", "QR 코드가 성공적으로 생성되었습니다. (상품 ID: " + productId + ")");
	    return "redirect:/product/detail?productId=" + productId;
	}

	// http://localhost:8088/product/downloadQr
	// QR코드 다운로드 처리
	@GetMapping("/downloadQr")
	public void downloadQrCode(
	        @RequestParam("productId") int productId,
	        HttpServletResponse response) throws Exception {

	    // 상품 정보 가져오기
	    ProductVO product = productService.getProductByID(productId);
	    if (product == null || product.getQrCodePath() == null) {
	        throw new IllegalArgumentException("QR 코드가 존재하지 않습니다.");
	    }

	    // QR 코드 파일 경로
	    File qrCodeFile = new File(product.getQrCodePath());
	    if (!qrCodeFile.exists()) {
	        throw new IllegalArgumentException("QR 코드 파일이 존재하지 않습니다.");
	    }
	    
	    // 파일명 인코딩 (한글 처리 포함)
	    String encodedFileName = URLEncoder.encode(qrCodeFile.getName(), "UTF-8").replaceAll("\\+", "%20");

	    // 파일 다운로드 설정
	    response.setContentType("application/octet-stream");
	    response.setHeader("Content-Disposition", "attachment; filename=\"" + encodedFileName + "\"");
	    response.setContentLengthLong(qrCodeFile.length());

	    // 파일 데이터 출력
	    try (FileInputStream fileInputStream = new FileInputStream(qrCodeFile);
	         OutputStream outputStream = response.getOutputStream()) {
	        byte[] buffer = new byte[1024];
	        int bytesRead;
	        while ((bytesRead = fileInputStream.read(buffer)) != -1) {
	            outputStream.write(buffer, 0, bytesRead);
	        }
	        outputStream.flush();
	    } 
	}
	
	// http://localhost:8088/product/detail
	// 상품 상세 정보 페이지
	@GetMapping("/detail")
	public String detail(@RequestParam("productId") int productId, Model model) throws Exception {
	    // 상품 상세 정보 조회
	    ProductVO product = productService.getProductByID(productId);
	    if (product == null) {
	        throw new IllegalArgumentException("상품 정보를 찾을 수 없습니다. productId: " + productId);
	    }

	    // 카테고리명 조회
	    String categoryName = categoryService.getCategoryNameById(product.getCategoryId());
	    if (categoryName == null) {
	        categoryName = "알 수 없음"; // 카테고리가 없을 경우 기본값 설정
	    }

	    // 뷰(JSP)에서 EL로 접근할 수 있도록 Model에 상품 및 카테고리 정보 등록
	    model.addAttribute("product", product);
	    model.addAttribute("categoryName", categoryName);

	    logger.info("연결된 뷰페이지(/product/detail.jsp) 이동");
	    return "product/detail"; // JSP 파일 경로
	}
	
	// http://localhost:8088/product/list
    @GetMapping("/product/list")
    public String listProducts(HttpServletRequest request, Model model) throws Exception{
	    // 세션에서 userId 가져오기
	    HttpSession session = request.getSession(false);
	    Long userId = (session != null) ? (Long)session.getAttribute("userId") : null;
        
	    // userId로 사용자 정보 조회
	    UserVO user = userService.getUserById(userId);
	    int businessId = user.getBusinessId();

        // 비즈니스 ID로 상품 리스트 조회
        List<ProductVO> products = productService.getProductsWithQRCode(businessId);

        // 모델에 데이터 추가
        model.addAttribute("products", products);

        return "product/list"; // /WEB-INF/views/product/list.jsp로 매핑
    }
	
}