package com.example.demo.controller;

import com.example.demo.entity.User;
import com.example.demo.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
public class AuthController {

    @Autowired
    private UserService userService;

    @GetMapping("/login")
    public String loginPage() {
        return "login"; // maps to login.jsp
    }

    @GetMapping("/signup")
    public String signupPage() {
        return "signup"; // maps to signup.jsp
    }

    @PostMapping("/signup")
    public String signup(@RequestParam String username, @RequestParam String password) {
        if (userService.findByUsername(username).isPresent()) {
            return "redirect:/signup?error=UserExists";
        }
        User user = new User();
        user.setUsername(username);
        user.setPassword(password); // TODO: hash password before storing
        userService.save(user);
        return "redirect:/login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String username, @RequestParam String password, HttpSession session) {
        var userOpt = userService.findByUsername(username);
        if (userOpt.isPresent() && userOpt.get().getPassword().equals(password)) {
            session.setAttribute("user", userOpt.get());
            return "redirect:/search";
        }
        return "redirect:/login?error=Invalid";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}
