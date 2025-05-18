package com.example.demo.repository;


import com.example.demo.entity.ResponseCodeList;
import com.example.demo.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ResponseCodeListRepository extends JpaRepository<ResponseCodeList, Long> {
    List<ResponseCodeList> findByUser(User user);
}
