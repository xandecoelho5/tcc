package br.edu.utfpr.e_markety.config.security;

import br.edu.utfpr.e_markety.config.security.service.UsuarioService;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import javax.servlet.Filter;

import static br.edu.utfpr.e_markety.config.security.ConfigUtils.*;

@EnableWebSecurity
@Configuration
@RequiredArgsConstructor
public class SecurityConfiguration {

    private final Filter authByTokenFilter;
    private final UsuarioService usuarioService;
    private final PasswordEncoder passwordEncoder;

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
            .authorizeHttpRequests(
                authorize -> {
                    try {
                        authorize
                            .antMatchers(HttpMethod.GET, GET_URLS).hasAnyRole("ADMIN", "FUNCIONARIO")
                            .antMatchers(HttpMethod.POST, POST_URLS).hasAnyRole("ADMIN", "FUNCIONARIO")
                            .antMatchers(HttpMethod.PUT, PUT_URLS).hasAnyRole("ADMIN", "FUNCIONARIO")
                            .antMatchers(HttpMethod.DELETE, DELETE_URLS).hasAnyRole("ADMIN", "FUNCIONARIO")
                            .antMatchers(HttpMethod.PATCH, PATCH_URLS).hasAnyRole("ADMIN", "FUNCIONARIO")
                            .antMatchers(HttpMethod.GET, "/empresa", "/usuario/current").permitAll()
                            .antMatchers(HttpMethod.POST, "/auth/**", "/usuario").permitAll()
                            .anyRequest().authenticated()
                            .and().csrf().disable()
                            .sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                            .and().addFilterBefore(authByTokenFilter, UsernamePasswordAuthenticationFilter.class);
                    } catch (Exception e) {
                        throw new RuntimeException(e);
                    }
                }
            );
        return http.build();
    }

    @Bean
    public AuthenticationProvider authenticationProvider() {
        DaoAuthenticationProvider provider = new DaoAuthenticationProvider();
        provider.setUserDetailsService(usuarioService);
        provider.setPasswordEncoder(passwordEncoder);
        return provider;
    }
}
