package com.stockm8.domain.vo;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class CategoryVO {
	private int categoryId;        // 카테고리 고유 ID
    private Integer parentId;      // 상위 카테고리 ID (NULL이면 대분류)
    private int businessId;        // 사업자 ID
    private String categoryName;   // 카테고리 이름
    private int level;             // 카테고리 계층 수준 (1=대분류, 2=소분류)
    private Timestamp createdAt;   // 카테고리 생성 일자
	public int getCategoryId() {
		return categoryId;
	}
	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}
	public Integer getParentId() {
		return parentId;
	}
	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}
	public int getBusinessId() {
		return businessId;
	}
	public void setBusinessId(int businessId) {
		this.businessId = businessId;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
	public Timestamp getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

    
}
