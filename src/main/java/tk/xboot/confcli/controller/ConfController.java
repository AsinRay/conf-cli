package tk.xboot.confcli.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RefreshScope
@RestController
public class ConfController {

    @Value("${app.hello}")
    private String hello;

    @Value("${app.xxx}")
    private String xxx;


    @GetMapping("hello")
    public String sayHello() {
        return this.hello;
    }


    @GetMapping("h")
    public String sayH() {
        return this.xxx;
    }
}
