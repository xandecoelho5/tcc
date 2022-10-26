package br.edu.utfpr.e_markety.config.security.service.impl;

import br.edu.utfpr.e_markety.config.security.dto.UsuarioDto;
import br.edu.utfpr.e_markety.config.security.service.UsuarioService;
import br.edu.utfpr.e_markety.exceptions.UserAlreadyRegisteredException;
import br.edu.utfpr.e_markety.model.Usuario;
import br.edu.utfpr.e_markety.repository.GenericRepository;
import br.edu.utfpr.e_markety.repository.UsuarioRepository;
import br.edu.utfpr.e_markety.service.impl.GenericServiceImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class UsuarioServiceImpl extends GenericServiceImpl<Usuario, Long, UsuarioDto> implements UsuarioService {

    private final UsuarioRepository repository;
    private final PasswordEncoder encoder;

    @Override
    protected GenericRepository<Usuario, Long> getRepository() {
        return repository;
    }

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        Optional<Usuario> user = repository.findByEmail(email);
        return user.orElseThrow(() -> new UsernameNotFoundException("Dados inválidos!"));
    }

    @Override
    protected void preSave(Usuario entity, Long id) {
        System.out.println("id: " + id);
        if (id == null) {
            String encoded = encoder.encode(entity.getSenha());
            entity.setSenha(encoded);
            entity.setFavoritosIds(new ArrayList<>());
        }
    }

    @Override
    public void verifyUserExists(String email) {
        var optionalUser = repository.findByEmail(email);
        if (optionalUser.isPresent()) {
            throw new UserAlreadyRegisteredException();
        }
    }
}
