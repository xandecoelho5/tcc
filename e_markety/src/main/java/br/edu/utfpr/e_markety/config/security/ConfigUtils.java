package br.edu.utfpr.e_markety.config.security;

public class ConfigUtils {

    private ConfigUtils() {}

    public static final String[] POST_URLS = {
            "/categoria",
            "/pedido",
            "/bairro",
            "/empresa",
            "/unidade-medida",
            "/produto",
    };

    public static final String[] PUT_URLS = {
            "/categoria/**",
            "/pedido",
            "/bairro/**",
            "/empresa/**",
            "/unidade-medida/**",
            "/produto/**",
    };

    public static final String[] DELETE_URLS = {
            "/categoria/**",
            "/pedido",
            "/bairro/**",
            "/empresa/**",
            "/unidade-medida/**",
            "/produto/**",
    };

    public static final String[] GET_URLS = {
            "/pedido/empresa/**",
            "/usuario",
    };
}
