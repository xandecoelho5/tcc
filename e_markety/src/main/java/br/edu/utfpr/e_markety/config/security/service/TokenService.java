package br.edu.utfpr.e_markety.config.security.service;

import org.springframework.security.core.Authentication;

public interface TokenService {

    String generateToken(Authentication authentication, Long empresaId);

    boolean isValidToken(String token);

    Long getUsuarioId(String token);

    Long getEmpresaId(String token);
}
