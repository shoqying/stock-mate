package com.stockm8.config;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@ControllerAdvice
public class GlobalExceptionHandler {

    private static final Logger logger = LoggerFactory.getLogger(GlobalExceptionHandler.class);

    /**
     * 공통 예외 처리
     */
    @ExceptionHandler(Exception.class)
    public String handleException(
            Exception e,
            HttpServletRequest request,
            RedirectAttributes rttr) {

        // 요청 URL 로그 기록
        logger.error("예외 발생 - URL: {}", request.getRequestURL());
        logger.error("예외 상세:", e);

        // 에러 메시지 설정
        rttr.addFlashAttribute("errorMessage", "서버 처리 중 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");

        // 리다이렉트 경로 결정
        String referer = request.getHeader("Referer"); // 이전 페이지로 이동
        return "redirect:" + (referer != null ? referer : "/");
    }
}