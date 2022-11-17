package br.edu.utfpr.e_markety.config;

import br.edu.utfpr.e_markety.config.security.AuthByTokenFilter;
import br.edu.utfpr.e_markety.config.security.service.TokenService;
import br.edu.utfpr.e_markety.repository.EmpresaRepository;
import br.edu.utfpr.e_markety.repository.UsuarioRepository;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import javax.servlet.Filter;

@Configuration
@EnableJpaAuditing
@RequiredArgsConstructor
public class BeanConfiguration {

    private final UsuarioRepository usuarioRepository;
    private final TokenService tokenService;
    private final EmpresaRepository empresaRepository;

    @Bean
    public Filter authByTokenFilter() {
        return new AuthByTokenFilter(tokenService, usuarioRepository, empresaRepository);
    }

    @Bean
    public ModelMapper getModelMapper() {
        return new ModelMapper();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}
