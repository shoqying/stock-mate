package com.stockm8.domain.vo;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class OrderItemVO {
    private int orderItemId;       // 주문 상세 항목 고유 ID
    private int orderId;           // 주문 ID
    private int productId;         // 주문 상품 ID
    private int warehouseId;       // 창고 ID
    private int quantity;          // 주문 수량
    private double unitPrice;      // 제품 단가
    private String remarks;        // 특정 상품에 대한 비고 사항
    private double stotalPrice;     // 주문 1건의 전체 총 금액
    private Timestamp createdAt;   // 생성 시간
    private Timestamp updatedAt;   // 수정 시간
    
    //JOIN을 통해 가져올 연관 정보
    private int stockId; // 가용 재고 구분위해 필요
    private ProductVO product;      // 상품 정보
    private String productName;     // 상품명
    private String productBarcode;  // 상품 바코드
    private String warehouseName;   // 창고명
    private String baseUnit;        // 기본 단위
    private String shipmentStatus;    // 입출고 상태
    
    
    
} //OrderItemVO
