package com.stockm8.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	//http://localhost:8088/
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home sweet home 모두 화이팅😁! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		return "main";
	}
	//http://localhost:8088/dashboard
	@RequestMapping(value = "/dashboard", method = RequestMethod.GET)
	public String dash(Locale locale, Model model) {
		logger.info("😁Welcome dashboad😁! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "dashboard";
	}
    // http://localhost:8088/qrScanner
	@RequestMapping(value = "/qrScanner", method = RequestMethod.GET)
	public String qrScanner(Locale locale, Model model) {
		logger.info("😁Welcome scanner😁! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "qrScanner";
	}
	
	// 대시보드사용법 - /howtouse (GET)
	@RequestMapping(value = "/howtouse", method = RequestMethod.GET)
	public String howtouseGET(Model model, HttpSession session) throws Exception {
		Long userId = (Long) session.getAttribute("userId");
//                if (id == null) {
//                    // 세션에 id가 없으면 에러 처리
//                    return "redirect:/user/main";
//                }
//               UserVO resultVO = userService.getUser(userId);
//               model.addAttribute("resultVO", resultVO);
		return "howtouse";
	}
	
	// 창고위치 - /location (GET)
		@RequestMapping(value = "/location", method = RequestMethod.GET)
		public String locationGET(Model model, HttpSession session) throws Exception {
			Long userId = (Long) session.getAttribute("userId");
//	                if (id == null) {
//	                    // 세션에 id가 없으면 에러 처리
//	                    return "redirect:/user/main";
//	                }
//	               UserVO resultVO = userService.getUser(userId);
//	               model.addAttribute("resultVO", resultVO);
			return "location";
		}
	
	
	// 상담하기 - /user/consultation (GET)
	@RequestMapping(value = "/consultation", method = RequestMethod.GET)
	public String consultationGET(Model model, HttpSession session) throws Exception {
		Long userId = (Long) session.getAttribute("id");

//                if (id == null) {
//                    // 세션에 id가 없으면 에러 처리
//                    return "redirect:/user/main";
//                }
//               UserVO resultVO = userService.getUser(userId, password );
//               model.addAttribute("resultVO", resultVO);
		return "consultation";
	}
	
	// 회사소개 - /intro (GET)
	@RequestMapping(value = "/intro", method = RequestMethod.GET)
	public String introGET(Model model, HttpSession session) throws Exception {
		Long userId = (Long) session.getAttribute("userId");
//                if (id == null) {
//                    // 세션에 id가 없으면 에러 처리
//                    return "redirect:/user/main";
//                }
//               UserVO resultVO = userService.getUser(userId);
//               model.addAttribute("resultVO", resultVO);
		return "/intro";
	}
	
	// 회사소개 - /price (GET)
	@RequestMapping(value = "/price", method = RequestMethod.GET)
	public String priceGET(Model model, HttpSession session) throws Exception {
		Long userId = (Long) session.getAttribute("userId");
//                if (id == null) {
//                    // 세션에 id가 없으면 에러 처리
//                    return "redirect:/user/main";
//                }
//               UserVO resultVO = userService.getUser(userId);
//               model.addAttribute("resultVO", resultVO);
		return "/price";
	}
	
}
