package tk.xboot.confcli.controller;

import org.springframework.beans.factory.annotation.Autowired
import tk.xboot.confcli.service.FooService;

class Foo {

    @Autowired
    FooService fooService;

    Object run() {
        // do something
        def f = fooService.findById(38)
        if (f != null) {
            return f.name
        }
        return null
    }

}
