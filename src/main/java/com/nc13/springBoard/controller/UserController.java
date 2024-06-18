package com.nc13.springBoard.controller;

import com.nc13.springBoard.model.UserDTO;
import com.nc13.springBoard.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/user/") // URL 값이 /user/ 의 하위경로일 경우 값을 해당 컨트롤러로 받길 원한다면
public class UserController {
    // 실제 SQL 통신을 담당할 Service 객체
    @Autowired
    private UserService userService;

    // 사용자가 로그인을 할 시 실행할
    // auth 메소드
    @PostMapping("auth") // form 에서 값을 받아올때 method post 로 전달 받음으로 PostMapping 을 사용하게 됨
    // Post 혹은 Get 방식으로 휍페이지의 값을 받아올 때에는
    // 파라미터에 해당 form 의 name 어트리뷰트와 같은 이름을 가진 파라미터를 적어주면 된다.
    // 또한, 해당 name 어트리뷰트를 필드로 가진 클래스 객체를 파라미터로 잡아주면
    // 자동으로 데이터가 바인딩 된다.
    public String auth(UserDTO userDTO, HttpSession session) {
        UserDTO result = userService.auth(userDTO);
        if (result != null) {
            // null != null - 로그인 성공
            session.setAttribute("logIn", result);
            return "redirect:/board/showAll";
        }

        // 만약 우리가 해당 메소드를 실행시키고 나서 특정 URL 로 이동시킬 때에는 다음과 같이 적어준다.
        return "redirect:/"; // 이 경우 index 로 돌아감
    }

    @GetMapping("register")
    public String showRegister() {
        return "user/register";
    }

    @PostMapping("register")
    public String register(UserDTO userDTO, RedirectAttributes redirectAttributes) {
        if (userService.validateUsername(userDTO)) {
            userService.register(userDTO);
        } else {
            // 회원가입 실패 메시지 전송
            // 회원가입 실패 시, 우리가 URL 을 /error 라는 곳으로 전송을 시켜주되,
            // 해당 페이지에서는 무슨 에러인지 알수 없도록
            // 메시지 내용을 여기서 담아서 보낸다.
            // 만약 다른 URL 로 이동할 때 어떠한 값을 보내주어야 하는 경우
            // RedirectAttributes 라는 것을 사용한다.
            // addFlashAttribute - 세션에 값을 담아서 페이지를 이동하고 난 이후 세션에서 삭제됨
            redirectAttributes.addFlashAttribute("message", "중복된 아이디로는 가입하실 수 없습니다.");
            return "redirect:/showMessage";
        }

        return "redirect:/";
    }
}
