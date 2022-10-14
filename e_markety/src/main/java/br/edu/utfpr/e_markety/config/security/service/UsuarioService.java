package br.edu.utfpr.e_markety.config.security.service;

import br.edu.utfpr.e_markety.config.security.dto.UsuarioDto;
import br.edu.utfpr.e_markety.model.Usuario;
import br.edu.utfpr.e_markety.service.GenericService;
import org.springframework.security.core.userdetails.UserDetailsService;

import java.util.Optional;

public interface UsuarioService extends GenericService<Usuario, Long, UsuarioDto>, UserDetailsService {

    Optional<Usuario> findByEmail(String email);
}
