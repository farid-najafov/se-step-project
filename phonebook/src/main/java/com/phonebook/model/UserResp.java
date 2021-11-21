package com.phonebook.model;

import java.util.UUID;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class UserResp {

    private UUID userId;
    private String operationType;
    private String operationStatus;

    public static UserResp success(UUID userId, String operationType) {
        return UserResp.builder().userId(userId).operationType(operationType).operationStatus("success").build();
    }

    public static UserResp failure(UUID userId, String operationType) {
        return UserResp.builder().userId(userId).operationType(operationType).operationStatus("failure").build();
    }
}
