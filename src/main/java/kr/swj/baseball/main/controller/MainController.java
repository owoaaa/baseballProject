package kr.swj.baseball.main.controller;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {

    @RequestMapping("/")
    public String main() {
        return "main"; // /WEB-INF/views/main.jsp 로 forward
    }
}