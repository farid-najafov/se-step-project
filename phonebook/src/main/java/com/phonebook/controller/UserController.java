package com.phonebook.controller;

import com.phonebook.entity.UserEntity;
import com.phonebook.model.UserReq;
import com.phonebook.model.UserResp;
import com.phonebook.service.UserService;
import java.util.List;
import java.util.UUID;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("user")
public class UserController {

    private final UserService userService;

    @PostMapping("add")
    public ResponseEntity<UserResp> addUser(@RequestBody UserReq request) {
        return ResponseEntity.ok(userService.save(request));
    }

    @PutMapping("edit/{userId}")
    public ResponseEntity<UserResp> editUser(@PathVariable UUID userId, @RequestBody UserReq request) {
        return ResponseEntity.ok(userService.edit(userId, request));
    }

    @DeleteMapping("delete/{userId}")
    public ResponseEntity<UserResp> deleteUser(@PathVariable UUID userId) {
        return ResponseEntity.ok(userService.delete(userId));
    }

    @GetMapping("list")
    public ResponseEntity<List<UserEntity>> getAllUsers() {
        return ResponseEntity.ok(userService.getAllUsers());
    }
}
