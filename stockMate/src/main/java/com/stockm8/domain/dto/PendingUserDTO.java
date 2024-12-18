package com.stockm8.domain.dto;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class PendingUserDTO {

    // 사용자 정보
    private Long userId;
    private String email;
    private String userName;
    private String userRole;
    private String telNumber;
    private Timestamp createdAt;

    // 사업자 정보
    private Integer businessId;
    private String businessNumber;
    private String businessName;

}
