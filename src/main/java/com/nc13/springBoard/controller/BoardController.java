package com.nc13.springBoard.controller;

import com.nc13.springBoard.model.BoardDTO;
import com.nc13.springBoard.model.ReplyDTO;
import com.nc13.springBoard.model.UserDTO;
import com.nc13.springBoard.service.BoardService;
import com.nc13.springBoard.service.ReplyService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/board/")
public class BoardController {

    @Autowired
    private BoardService boardService;
    @Autowired
    private ReplyService replyService;

    @GetMapping("showAll")
    public String moveToFirstPage() {
        return "redirect:/board/showAll/1";
    }

    @GetMapping("showAll/{pageNo}")
    public String showAll(HttpSession session, Model model, @PathVariable int pageNo) {
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");
        if (logIn == null) {
            return "redirect:/";
        }

        // 가장 마지막 페이지의 번호
        int maxPage = boardService.selectMaxPage();
        model.addAttribute("maxPage", maxPage);

        // --- 페이지네이션 ---
        // -> 여러 게시글이 있을 경우
        // 페이지 단위로 끊어서 보여준다.
        // 예시: 300개의 게시글이 있을 경우
        // 15개의 페이지로 나눈다면 한 페이지에 들어가는 글의 갯수 = 20개
        // 글의 갯수가 147개인 페이지의 총 갯수 = 8개

        // --- 페이지네이션의 주된 생김새 ---
        // << < 1 2 [3] 4 5 > >>
        // <<, >>: 맨 앞 뒤
        // <, >: 특정 단위 갯수만큼 앞 뒤
        // []: 현재 보고있는 페이지

        // 우리가 pageNo를 사용하며
        // 시작페이지 번호
        // 끝페이지 번호
        // 을 계산해 주어야 한다.
        // 이때에는 크게 3가지 가 있다.

        // 1. 현제 페이지가 3 이하일 경우
        // 시작: 1, 끝: 5

        // 2. 현재 페이지가 최대 페이지 -2 이상일 경우
        // 시작: 최대페이지 -4, 끝: 최대페이지

        // 3. 그 외
        // 시작: 현재페이지 -2, 끝: 현재페이지 +2

        // 시작 페이지
        int startPage;

        // 끝 페이지
        int endPage;

        if (maxPage < 5) { // 페이지가 5 미만인 경우
            startPage = 1;
            endPage = maxPage;
        } else if (pageNo <= 3) { // 페이지가
            startPage = 1;
            endPage = 5;
        } else if (pageNo >= maxPage - 2) { //
            startPage = maxPage - 4;
            endPage = maxPage;
        } else { //
            startPage = pageNo - 2;
            endPage = pageNo + 2;
        }

        model.addAttribute("curPage", pageNo);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);

        List<BoardDTO> list = boardService.selectAll(pageNo);
        model.addAttribute("list", list);

        return "board/showAll";
    }

    @GetMapping("write")
    public String showWrite(HttpSession session) {
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");
        if (logIn == null) {
            return "redirect:/";
        }
        return "board/write";
    }

    @PostMapping("write")
    public String write(HttpSession session, BoardDTO boardDTO) {
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");
        if (logIn == null) {
            return "redirect:/";
        }
        boardDTO.setWriterId(logIn.getId());
        boardService.insert(boardDTO);

        return "redirect:/board/showOne/" + boardDTO.getId();
        // return "redirect:/board/showOne"; 를 이용하여 게시판으로 돌아가는 것이 아닌
        // 내가 방금 작성한 게시물로 바로 이동하도록 지정함. BoardMapper 에서 설정해줘야함
    }

    // 우리가 주소창에 있는 값을 매핑해줄 수 있다.
    @GetMapping("showOne/{id}")
    public String showOne(HttpSession session, @PathVariable int id, Model model, RedirectAttributes redirectAttributes) {

        UserDTO logIn = (UserDTO) session.getAttribute("logIn");
        if (logIn == null) {
            return "redirect:/";
        }

        BoardDTO boardDTO = boardService.selectOne(id);
        if (boardDTO == null) {
            redirectAttributes.addFlashAttribute("message", "존재하지 않는 게시물 입니다.");
            return "redirect:/showMessage";
        }

        List<ReplyDTO> replyList = replyService.selectAll(id);

        model.addAttribute("boardDTO", boardDTO);
        model.addAttribute("replyList", replyList);

        return "board/showOne";
        // redirect 를 붙이면 링크 속 값이 휘발되니 주의할 것
    }

    @GetMapping("update/{id}")
    public String showUpdate(@PathVariable int id, HttpSession session, RedirectAttributes redirectAttributes, Model model) {

        // 로그인 상태 검증
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");
        if (logIn == null) {
            return "redirect:/";
        }

        // 게시물 존재 검증
        BoardDTO boardDTO = boardService.selectOne(id);
        if (boardDTO == null) {
            redirectAttributes.addFlashAttribute("message", "존재하지 않는 게시물 입니다.");
            return "redirect:/showMessage";
        }

        // 작성자 본인 검증
        if (boardDTO.getWriterId() != logIn.getId()) {
            redirectAttributes.addFlashAttribute("message", "권한이 없습니다.");
            return "redirect:/showMessage";
        }

        model.addAttribute("boardDTO", boardDTO);

        return "board/update";
    }

    @PostMapping("update/{id}")
    public String update(@PathVariable int id, HttpSession session, RedirectAttributes redirectAttributes, BoardDTO attempt) {
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");
        if (logIn == null) {
            return "redirect:/";
        }

        BoardDTO boardDTO = boardService.selectOne(id);
        if (boardDTO == null) {
            redirectAttributes.addFlashAttribute("message", "존재하지 않는 게시물 입니다.");
            return "redirect:/showMessage";
        }

        if (logIn.getId() != boardDTO.getWriterId()) {
            redirectAttributes.addFlashAttribute("message", "권한이 없습니다.");
            return "redirect:/showMessage";
        }

        attempt.setId(id);

        boardService.update(attempt);

        return "redirect:/board/showOne/" + id;
    }

    @GetMapping("delete/{id}")
    public String delete(@PathVariable int id, HttpSession session, RedirectAttributes redirectAttributes) {
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");
        if (logIn == null) {
            return "redirect:/";
        }

        BoardDTO boardDTO = boardService.selectOne(id);

        if (boardDTO == null) {
            redirectAttributes.addFlashAttribute("message", "존재하지 않는 게시물 입니다.");
            return "redirect:/showMessage";
        }

        if (boardDTO.getWriterId() != logIn.getId()) {
            redirectAttributes.addFlashAttribute("message", "권한이 없습니다.");
            return "redirect:/showMessage";
        }

        boardService.delete(id);

        return "redirect:/board/showAll";
    }

    // 해당 코드는 test 를 위해 게시글 300개를 작성합니다.
//    @GetMapping("test")
//    public String test(HttpSession session) {
//        UserDTO logIn = (UserDTO) session.getAttribute("logIn");
//        if (logIn == null) {
//            return "redirect:/";
//        }
//
//        for (int i = 1; i <= 300; i++) {
//            BoardDTO boardDTO = new BoardDTO();
//            boardDTO.setTitle("테스트 제목" + i);
//            boardDTO.setContent("테스트 " + i + "번 글 내용입니다.");
//            boardDTO.setWriterId(logIn.getId());
//            boardService.insert(boardDTO);
//        }
//
//        return "redirect:/board/showAll";
//    }





}
