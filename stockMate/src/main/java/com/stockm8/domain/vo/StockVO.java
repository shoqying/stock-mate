package com.stockm8.domain.vo;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class StockVO {
	private int stockId; // 고유 재고 ID
	private int productId; // 상품 ID
	private int warehouseId; // 창고 ID
	private int businessId; // 사업자 ID

	private int totalQuantity;  // 창고 내 총 재고 수량
	private int reservedQuantity;  // 예약된 수량

	// availableStock은 totalQuantity - reservedQuantity로 계산
	private int availableStock;  // 사용 가능한 재고 (totalQuantity - reservedQuantity)

	// totalQuantity에 대한 getter
	public int getTotalQuantity() {
		return totalQuantity;
	}

	public void setTotalQuantity(int totalQuantity) {
		this.totalQuantity = totalQuantity;
			updateAvailableStock();  // 값이 변경되면 availableStock을 자동으로 업데이트
	}

	// reservedQuantity에 대한 getter
	public int getReservedQuantity() {
	    	return reservedQuantity;
	}

	public void setReservedQuantity(int reservedQuantity) {
		this.reservedQuantity = reservedQuantity;
		updateAvailableStock();  // 값이 변경되면 availableStock을 자동으로 업데이트
	}

	// availableStock을 계산하는 getter
	public int getAvailableStock() {
		return availableStock;
	}

	// availableStock 계산
	private void updateAvailableStock() {
		this.availableStock = this.totalQuantity - this.reservedQuantity;
	}
	
	private Timestamp createdAt; // 재고 등록 시간 
	private Timestamp updatedAt; // 최근 수정 시간

	private String description; // 재고 설명

	private String dscription; // 재고 설명
    	private Boolean isDeleted;     // 논리 삭제 여부 (true: 삭제됨, false: 활성)

}
