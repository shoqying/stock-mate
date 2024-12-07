package com.stockm8.domain.vo;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class UserVO {
    // UserDTO (Data Transfer Object)
    // UserVO (Value Object)

    private int userId;           // 사용자 고유 ID
    private String email;          // 사용자 이메일(로그인 ID)
    private String password;       // 사용자 비밀번호
    private String name;           // 사용자 이름
    private String role;           // 사용자 역할 (admin, manager, staff)
    private Integer businessId;   // 사업자 고유 ID (NULL 가능)
    private String telNumber;     // 사용자 전화번호
    private Timestamp createdAt;  // 계정 생성 날짜
    private Integer createdBy;    // 계정을 승인한 사용자 ID
    private Timestamp updatedAt;  // 계정 수정 날짜
    private boolean isSubscribed; // 구독 여부
    private String status;         // 계정 상태 (approved, pending, rejected
    
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public Integer getBusinessId() {
		return businessId;
	}
	public void setBusinessId(Integer businessId) {
		this.businessId = businessId;
	}
	public String getTelNumber() {
		return telNumber;
	}
	public void setTelNumber(String telNumber) {
		this.telNumber = telNumber;
	}
	public Timestamp getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}
	public Integer getCreatedBy() {
		return createdBy;
	}
	public void setCreatedBy(Integer createdBy) {
		this.createdBy = createdBy;
	}
	public Timestamp getUpdatedAt() {
		return updatedAt;
	}
	public void setUpdatedAt(Timestamp updatedAt) {
		this.updatedAt = updatedAt;
	}
	public boolean isSubscribed() {
		return isSubscribed;
	}
	public void setSubscribed(boolean isSubscribed) {
		this.isSubscribed = isSubscribed;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
    
}

