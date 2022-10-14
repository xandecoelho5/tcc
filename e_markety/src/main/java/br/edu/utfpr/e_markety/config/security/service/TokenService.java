package br.edu.utfpr.e_markety.config.security.service;

import org.springframework.security.core.Authentication;

public interface TokenService {

    String generateToken(Authentication authentication);

    boolean isValidToken(String token);

    Long getUserId(String token);
}
