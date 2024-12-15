package com.stockm8.domain.dto;

import java.sql.Timestamp;

import com.stockm8.domain.vo.BusinessVO;
import com.stockm8.domain.vo.UserVO;

import lombok.Data;

@Data
public class WarehouseDetailDTO {
    private int warehouseId;              // 창고 고유 ID
    private String warehouseName;         // 창고 이름
    private String warehouseRegion;       // 창고 지역 정보
    private String warehouseLocation;     // 창고 위치
    private int businessId;
    private BusinessVO business;          // 회사명 (추가)
    private Long userId;
    private UserVO user;                  // 관리자명 (추가)
    private Timestamp createdAt;          // 창고 등록 날짜
    private Timestamp updatedAt;          // 창고 수정 날짜
    private int warehouseCapacity;        // 창고 저장 용량
    private String warehouseDescription;  // 창고 상세 설명
    private String warehouseStatus;       // 창고 상태 ('active', 'inactive')
}
