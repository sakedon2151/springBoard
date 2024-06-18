package com.nc13.springBoard.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

@Controller
public class ErrorController {

    @GetMapping("/showMessage")
    public String showError(@ModelAttribute("message") String message, Model model) {
        // @ModelAttribute() String message -> 현재 redirectAttributes 를 통해 세션에 올라간 message 값을 찾아서 이곳 message 에 담는다.

        model.addAttribute("message", message);

        return "showMessage";
    }
}
