package com.example.demo.service;


import com.example.demo.entity.ResponseCodeList;
import com.example.demo.entity.User;
import com.example.demo.repository.ResponseCodeListRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ResponseCodeListService {
    @Autowired
    private ResponseCodeListRepository listRepository;

    public ResponseCodeList save(ResponseCodeList list) {
        return listRepository.save(list);
    }

    public List<ResponseCodeList> findByUser(User user) {
        return listRepository.findByUser(user);
    }

    public void deleteById(Long id) {
        listRepository.deleteById(id);
    }

    public ResponseCodeList findById(Long id) {
        return listRepository.findById(id).orElse(null);
    }
}
