package tk.xboot.confcli.service;

import org.springframework.stereotype.Service;
import tk.xboot.confcli.Bean;

@Service
public class FooService {


    public Bean findById(int id){
        return new Bean(id + "");
    };
}
