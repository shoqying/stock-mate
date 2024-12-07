package com.stockm8.service;

import java.util.List;

import com.stockm8.domain.vo.UserVO;

public interface UserService {

	//실행하려는 동작 추상메서드로 구현
	
	// 회원가입
	public void userJoin(UserVO vo);
	
	// 로그인 체크
	public UserVO userLogin(UserVO vo);
	
	// 회원정보 조회
	public UserVO getuser(String user_id);
	
	
	// 회원정보 수정
	public void updateuser(UserVO userVO);
	
	// 회원정보 삭제
	public int deleteuser(UserVO userVO);
	
	// 회원정보 목록조회
	public List<UserVO> userList();
	
	
	
}