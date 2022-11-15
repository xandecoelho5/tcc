package br.edu.utfpr.e_markety.config.security.service.impl;

import br.edu.utfpr.e_markety.config.security.dto.LoginDto;
import br.edu.utfpr.e_markety.config.security.dto.TokenDto;
import br.edu.utfpr.e_markety.config.security.service.AuthService;
import br.edu.utfpr.e_markety.config.security.service.TokenService;
import br.edu.utfpr.e_markety.exceptions.UninformedEmpresaException;
import br.edu.utfpr.e_markety.repository.EmpresaRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AuthServiceImpl implements AuthService {

    private final AuthenticationProvider authProvider;
    private final TokenService tokenService;
    private final EmpresaRepository empresaRepository;

    @Override
    public TokenDto authenticate(LoginDto loginDto) {
        UsernamePasswordAuthenticationToken loginData = loginDto.convert();
        Authentication authentication = authProvider.authenticate(loginData);

        if (loginDto.getEmpresaId() == null) {
            var empresa = empresaRepository.findByUsuarioEmail(loginDto.getLogin());
            loginDto.setEmpresaId(empresa.orElseThrow(UninformedEmpresaException::new).getId());
        }

        return new TokenDto(tokenService.generateToken(authentication, loginDto.getEmpresaId()), "Bearer");
    }
}
