package com.stockm8.interceptor;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.stockm8.domain.enums.UserRole;
import com.stockm8.domain.vo.UserVO;
import com.stockm8.service.UserService;

@Component
public class AdminInterceptor implements HandlerInterceptor {

	private static final Logger logger = LoggerFactory.getLogger(AdminInterceptor.class);
	
	@Autowired
	private UserService userService; // 유저 정보를 가져오기 위한 서비스 클래스

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
	    HttpSession session = request.getSession(false);
	    Long userId = (session != null) ? (Long) session.getAttribute("userId") : null;

	    // 1. 세션에서 사용자 ID 확인
	    if (userId == null) {
	        logger.warn("세션에 유저 ID가 없습니다. 로그인 페이지로 이동합니다.");
	        saveRequestedUrlToSession(request);
	        return sendErrorMessage(request, response, "세션이 만료되었습니다. 다시 로그인해주세요.", "/user/signin");
	    }

	    // 2. DB에서 사용자 정보 조회
	    UserVO user = userService.getUserById(userId);
	    if (user == null) {
	        logger.warn("해당 유저({}) 정보를 찾을 수 없습니다. 회원가입 페이지로 이동합니다.", userId);
	        return sendErrorMessage(request, response, "유저 정보를 찾을 수 없습니다. 회원가입을 진행해주세요.", "/user/signup");
	    }

	    // 3. 삭제된 계정 확인
	    if (Boolean.TRUE.equals(user.getIsDeleted())) {
	        logger.warn("삭제된 유저({})입니다. 로그인 페이지로 이동합니다.", userId);
	        return sendErrorMessage(request, response, "삭제된 계정입니다. 관리자에게 문의해주세요.", "/user/signin");
	    }

	    // 4. 관리자 권한 확인
	    if (user.getUserRole() != UserRole.ADMIN) {
	        logger.warn("권한 없는 접근 시도 (유저 ID: {}, 역할: {}).", userId, user.getUserRole());
	        return sendErrorMessage(request, response, "관리자 전용 페이지입니다. 접근 권한이 없습니다.", "/user/signin");
	    }

	    // 검증 성공: 사용자 정보 저장
	    logger.info("관리자 확인 완료 (유저 ID: {}, 이름: {}).", userId, user.getUserName());
	    request.setAttribute("currentUser", user);
	    return true;
	}

	/**
	 * 에러 메시지와 함께 리다이렉트 처리
	 */
	private boolean sendErrorMessage(HttpServletRequest request, HttpServletResponse response, String message, String redirectUrl) throws IOException {
	    request.getSession().setAttribute("errorMessage", message);
	    response.sendRedirect(request.getContextPath() + redirectUrl);
	    return false; // 요청 중단
	}

	/**
	 * 요청한 URL을 세션에 저장 (로그인 후 리다이렉트를 위해)
	 */
	private void saveRequestedUrlToSession(HttpServletRequest request) {
	    String requestedUrl = request.getRequestURI();
	    String queryString = request.getQueryString();
	    if (queryString != null) {
	        requestedUrl += "?" + queryString;
	    }
	    request.getSession().setAttribute("requestedUrl", requestedUrl);
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		
	}
	
}
