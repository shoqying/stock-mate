package com.stockm8.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.stockm8.domain.vo.UserVO;
import com.stockm8.service.BusinessService;
import com.stockm8.service.UserService;

@Controller
@RequestMapping("/business")
public class BusinessController {
	
	private static final Logger logger = LoggerFactory.getLogger(BusinessController.class);
	
	@Autowired
	private BusinessService businessService;
	
	@Autowired
	private UserService userService;
	
	// http://localhost:8088/business/register
	// 회사 등록 페이지
	@GetMapping("/register")
	public String registBusinessGET(Model model, 
									HttpServletRequest request,
									RedirectAttributes rttr) throws Exception {
		logger.info("registBusinessGET() 호출");
		
	    // 세션에서 userId 가져오기
	    HttpSession session = request.getSession(false);
	    Long userId = (session != null) ? (Long)session.getAttribute("userId") : null;
        
        // userId로 사용자 정보 조회
        if (userId == null) {
            // 에러 메시지와 함께 로그인 페이지로 리다이렉트
            rttr.addFlashAttribute("errorMessage", "회원 정보가 없습니다. 로그인 해주세요.");
            return "redirect:/user/signin"; // 로그인 페이지로 리다이렉트
        }

        UserVO user = userService.getUserById(userId);
        if (user.getBusinessId() != null) {
            // 이미 비즈니스 ID가 있으면 대시보드로 이동
            return "redirect:/dashboard"; // 대시보드 페이지로 리다이렉트
        }
        
        // 에러 메시지가 있을 경우, 해당 메시지 추가
        String errorMessage = (String) request.getAttribute("errorMessage");
        if (errorMessage != null) {
            model.addAttribute("errorMessage", errorMessage);
        }
        
    	// FlashMap에서 에러 메시지 확인
//        Map<String, ?> flashMap = RequestContextUtils.getInputFlashMap(request);
//        if (flashMap != null) {
//            String errorMessage = (String) flashMap.get("errorMessage");
//            if (errorMessage != null) {
//                model.addAttribute("errorMessage", errorMessage);
//            }
//        }

        logger.info("연결된 뷰페이지(/business/register.jsp) 이동");
        return "business/register"; // 회사 등록 폼 페이지로 이동
	}

}
