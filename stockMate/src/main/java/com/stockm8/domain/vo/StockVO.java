package com.stockm8.domain.vo;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class StockVO {
    private int stockId;           // 고유 재고 ID
    private int productId;         // 상품 ID
    private int warehouseId;       // 창고 ID
    private int businessId;        // 사업자 ID
    private int totalQuantity;     // 창고 내 총 재고 수량
    private int reservedQuantity;  // 예약된 수량
    private int availableStock;    // 사용 가능한 재고
    private Timestamp updatedAt;   // 최근 수정 시간
    private Timestamp createdAt;   // 재고 등록 일자
    private String description;    // 재고 설명
    private boolean isDeleted;     // 논리 삭제 여부
    
    private ProductVO product;     // 상품 정보 (JOIN 용)
    private String warehouseName;  // 창고명 (JOIN 용)

} //StockVO
