package br.edu.utfpr.e_markety.config.security.service;

import br.edu.utfpr.e_markety.config.security.dto.LoginDto;
import br.edu.utfpr.e_markety.config.security.dto.TokenDto;

public interface AuthService {

    TokenDto authenticate(LoginDto loginDto);
}
