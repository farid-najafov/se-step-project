package com.phonebook.service;

import com.phonebook.entity.UserEntity;
import com.phonebook.model.UserReq;
import com.phonebook.model.UserResp;
import com.phonebook.repo.UserRepo;
import java.util.List;
import java.util.UUID;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepo userRepo;

    public UserResp save(UserReq request) {
        var userEntity = UserEntity.builder().name(request.getName()).phone(request.getPhone()).build();
        try {
            var saved = userRepo.save(userEntity);
            return UserResp.success(saved.getUserId(), "add");
        } catch (Exception ex) {
            return UserResp.failure(null, "add");
        }
    }

    public UserResp edit(UUID userId, UserReq request) {
        try {
            var userEntity = userRepo.getById(userId);
            userEntity.setName(request.getName());
            userEntity.setPhone(request.getPhone());
            var saved = userRepo.save(userEntity);
            return UserResp.success(saved.getUserId(), "edit");
        } catch (Exception ex) {
            return UserResp.failure(userId, "edit");
        }
    }

    public UserResp delete(UUID userId) {
        try {
            userRepo.deleteById(userId);
            return UserResp.success(userId, "delete");
        } catch (Exception ex) {
            return UserResp.failure(userId, "edit");
        }
    }

    public List<UserEntity> getAllUsers() {
        return userRepo.findAll();
    }
}
