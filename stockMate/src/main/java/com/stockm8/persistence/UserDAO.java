package com.stockm8.persistence;

import java.util.List;

import com.stockm8.domain.vo.UserVO;

public interface UserDAO {
	// 회원가입 동작
	public void userJoin(UserVO vo);
	
	// 로그인 체크 동작
	public UserVO userLogin(UserVO vo);
	
	// 회원정보 조회동작
	public UserVO getUser(String user_id);
	
	// 회원정보 수정동작
	public void updateUser (UserVO uvo);
	
	// 회원정보 삭제동작
	public int deleteUser (UserVO dvo);
	
	// 회원정보 목록(list)
	public List<UserVO> getUserList();
}
