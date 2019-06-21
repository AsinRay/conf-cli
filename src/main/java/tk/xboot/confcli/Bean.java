package tk.xboot.confcli;

public class Bean {

    org.springframework.boot.context.config.ConfigFileApplicationListener lis = null;

    public Bean(String name) {
        this.name = name;
    }

    private String name;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
