package br.edu.utfpr.e_markety.config.security;

import br.edu.utfpr.e_markety.config.security.service.TokenService;
import br.edu.utfpr.e_markety.config.security.service.UsuarioService;
import br.edu.utfpr.e_markety.repository.UsuarioRepository;
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

@EnableWebSecurity
@Configuration
@RequiredArgsConstructor
public class SecurityConfiguration {

    private final UsuarioRepository usuarioRepository;
    private final UsuarioService usuarioService;
    private final TokenService tokenService;
    private final PasswordEncoder passwordEncoder;

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                .passwordManagement(management -> management.changePasswordPage("/update-password"))
                .authorizeHttpRequests(
                        authorize -> {
                            try {
                                authorize
                                        .antMatchers(HttpMethod.POST, "/auth").permitAll()
                                        .antMatchers(HttpMethod.POST, "/usuario").permitAll()
                                        .anyRequest().permitAll() // authenticated()
                                        .and().csrf().disable()
                                        .sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                                        .and().addFilterBefore(new AuthByTokenFilter(tokenService, usuarioRepository), UsernamePasswordAuthenticationFilter.class);
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
