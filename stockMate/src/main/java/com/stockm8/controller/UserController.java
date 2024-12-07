package com.stockm8.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.stockm8.domain.vo.UserVO;
import com.stockm8.service.UserService;

@Controller
@RequestMapping(value = "/user/*")
// *.me 처럼 /user/~ 시작하는 모든주소를 처리하겠다.
public class UserController {

	private static final Logger logger = LoggerFactory.getLogger(UserController.class);

	// userDAO 객체 root-context.xml주입
	// @Inject
	// private userDAO mdao;
	
	@Autowired
	private UserService userService;

	// http://localhost:8088/web/userJoin (x)
	// http://localhost:8088/web/join (x)
	// http://localhost:8088/join (x)
	// http://localhost:8088/user/login (o)
	// http://localhost:8088/user/main (o)
	// http://localhost:8088/user/join (o)
	// http://localhost:8088/user/dash (o)
	// http://localhost:8088/user/info1 (o)

	// 회원가입 - 정보입력 / GET 방식
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public void userJoinGET() throws Exception {
		logger.info(" /user/join -> userJoinGET() 실행");
		logger.info(" 주소에 맞는 view페이지 매핑(보여주기)");
		// return "/user/join"; // /view/user/join.jsp 연결
		
	}

	// ./user/join?userid=qqqq&userpw=1111...
	// 회원가입 - 정보처리 / POST 방식
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String userJoinPOST(/* @ModelAttribute */ UserVO uservo) throws Exception {
		logger.info("/user/join -> userJoinPOST()실행 ");
		logger.info("Role received: " + uservo.getRole());

		// 전달정보 저장
		logger.info("vo :" + uservo);

		// userDAO객체가 필요 => 주입
		// DB에 정보를 전달 - 회원가입동작 실행
		// mdao.userJoin(vo); // => 잘``못됨
		// 서비스 -> DAO 호출
		userService.userJoin(uservo);

		// 로그인 페이지로 이동
		return "redirect:/user/login";
	}

	// http://localhost:8088/user/login (GET)
	// 로그인 - 정보입력 / GET
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public void userLoginGET() {
		logger.info(" userLoginGET() 호출 ");
		logger.info(" /user/login.jsp 뷰페이지 연결 ");
	}

	// 로그인 - 정보처리 / POST
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String userLoginPOST(UserVO uservo, RedirectAttributes rttr, HttpSession session) {
		logger.info(" userLoginPOST() 호출 ");

		// 전달정보(입력한 로그인정보) 저장
		logger.info("vo : " + uservo);

		// 서비스 -> DAO(로그인 체크)호출
		UserVO resultVO = userService.userLogin(uservo);
		// 호출결과에 따라 main페이지/로그인페이지로 이동
		if (resultVO != null) {
			// 로그인 성공!
			logger.info(" 로그인 성공!!! ");
			logger.info(" /user/main => /user/main.jsp 뷰페이지 연결 ");

			// main페이지로 정보 전달
			rttr.addFlashAttribute("result", "loginOK");
			// 사용자의 정보(아이디) 세션에 저장
			session.setAttribute("id", resultVO.getUserId());

			return "redirect:/user/main";
		}

		logger.info(" 로그인 실패! ");
		return "redirect:/user/login";
	}

	// 메인페이지 - GET
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public void mainGET() {
		logger.info(" mainGET() 호출 ");

		logger.info(" /user/main -> /user/main.jsp 연결 ");
	}

	// 대시보드 페이지 - GET
	@RequestMapping(value = "/dash", method = RequestMethod.GET)
	public void dashGET() {
		logger.info(" dashGET() 호출 ");

		logger.info(" /user/main -> /user/dash.jsp 연결 ");
	}

	// 로그아웃 - GET
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String userLogoutGET(HttpSession session) {
		logger.info(" userLogoutGET() 호출");

		// 로그아웃 처리(세션정보 초기화)
		session.invalidate();

		// 로그아웃 처리 후 페이지 이동

		return "redirect:/user/main";
	}

	// 회원정보 조회 - /user/info1 (GET)
	@RequestMapping(value = "/info1", method = RequestMethod.GET)
	public String userInfo1GET(Model model, HttpSession session) {
		String id = (String) session.getAttribute("id");
//	    if (id == null) {
//	        // 세션에 id가 없으면 에러 처리
//	        return "redirect:/user/main";
//	    }
		UserVO resultVO = userService.getuser(id);
		model.addAttribute("resultVO", resultVO);
		return "user/info1";
	}

//	// 회원정보 조회 - /user/info1 (GET)
//	@RequestMapping(value = "/info1", method = RequestMethod.GET)
//	public void userInfo1GET(
//			Model model
//			,@SessionAttribute(name = "id") String id) {
//		logger.info(" userInfo1GET() 호출");
//		
//		// 세션에 저장된 아이디 정보를 가져오기
//		logger.info(" id : "+id);
//		
//		// 서비스 -> DAO 호출(회원정보 조회)
//		userVO resultVO = userservice.getuser(id);
//		// 결과정보를 저장 view페이지 전달 & 출력 (Model객체)		
//		model.addAttribute("resultVO", resultVO);
//		logger.info(" /user/info => /user/info1.jsp 연결");
//	}
//	

	// 회원정보 수정 - GET
	// (기존정보를 가져와서 보여주고, 수정할 정보를 입력)
	@RequestMapping(value = "/editInfo1", method = RequestMethod.GET)
	public void userUpdateGET(@SessionAttribute("id") String id, Model model) {
		logger.info(" userUpdateGET() 호출 ");

		// 사용자의 ID정보를 가져오기(세션)
		logger.info("id : " + id);

		// 서비스 -> DAO 회원정보 가져오는 동작 호출
		UserVO resultVO = userService.getuser(id);

		// 연결된 뷰페이지에 출력
		// => model 객체에 정보 저장
		model.addAttribute("resultVO", resultVO);
		// /user/update.jsp 뷰페이지 연결
	}

	// 회원정보 수정 - POST
	// (수정된 정보를 전달받아서 정보 수정)
	@RequestMapping(value = "/editInfo2", method = RequestMethod.POST)
	public String userUpdatePOST(UserVO uservo) {
		logger.info(" userUpdatePOST() ");

		// 전달정보(수정정보) 저장
		logger.info("vo : " + uservo);

		// 서비스 -> DAO 호출 (회원정보 수정)
		userService.updateuser(uservo);

		// 수정완료시 메인페이지로 이동
		return "redirect:/user/dash";
	}

	// 회원정보 삭제 - 비밀번호 입력 (GET)
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public String userDeleteGET() {
		logger.info("userDeleteGET() 실행 ");
		logger.info(" /user/delete.jsp 페이지 연결");

		return "/user/delete";
	}

	// 회원정보 삭제 - 아이디/비밀번호 확인후 정보 삭제 (POST)
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public String userDeletePOST(UserVO uservo, HttpSession session) {
		logger.info(" userDeletePOST() 실행 ");

		// 전달된 파라메터(id,pw)를 저장
		logger.info(" vo : " + uservo);

		// 서비스 -> DAO 호출 (정보 삭제)
		int result = userService.deleteuser(uservo);

		if (result == 0) {
			// 삭제 실패
			logger.info(" 정보 삭제 실패!! ");
			return "redirect:/user/delete";
		}

		// 삭제 성공
		logger.info(" 정보 삭제 성공! ");
		// 삭제 후 정보초기화
		session.invalidate();

		return "redirect:/user/main";
	}

	// 회원목록 조회 - 회원정보를 리스트 형태로 가져오기 (GET)
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String userListGET(Model model) {
		logger.info(" userListGET() 호출 ");

		// 서비스 -> DAO (회원 리스트 가져오기 동작)
		List<UserVO> userList = userService.userList();
		logger.info(" 회원수 : " + userList.size());

		// 뷰페이지에 정보를 전달(model객체)
		model.addAttribute("userList", userList);

		// /user/list.jsp 페이지
		return "/user/list";
	}

}// Controller
