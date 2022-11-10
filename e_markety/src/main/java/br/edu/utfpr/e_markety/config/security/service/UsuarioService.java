package br.edu.utfpr.e_markety.config.security.service;

import br.edu.utfpr.e_markety.config.security.dto.SenhaDto;
import br.edu.utfpr.e_markety.config.security.dto.UsuarioDto;
import br.edu.utfpr.e_markety.config.security.dto.UsuarioEditDto;
import br.edu.utfpr.e_markety.service.GenericService;
import org.springframework.security.core.userdetails.UserDetailsService;

public interface UsuarioService extends GenericService<Long, UsuarioDto>, UserDetailsService {

    void verifyUserExists(String email);

    UsuarioDto updateUsuario(UsuarioEditDto usuarioDto);

    void updateSenha(SenhaDto senhaDto);
}
