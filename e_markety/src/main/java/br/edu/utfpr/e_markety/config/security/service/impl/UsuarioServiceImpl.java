package br.edu.utfpr.e_markety.config.security.service.impl;

import br.edu.utfpr.e_markety.config.security.dto.SenhaDto;
import br.edu.utfpr.e_markety.config.security.dto.UsuarioDto;
import br.edu.utfpr.e_markety.config.security.dto.UsuarioEditDto;
import br.edu.utfpr.e_markety.config.security.service.UsuarioService;
import br.edu.utfpr.e_markety.exceptions.CurrentPasswordException;
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
import java.util.Objects;
import java.util.Optional;

import static br.edu.utfpr.e_markety.utils.PrincipalUtils.getLoggedUsuario;

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
        if (id == null) {
            String encoded = encoder.encode(entity.getSenha());
            entity.setSenha(encoded);
            entity.setFavoritosIds(new ArrayList<>());
        }
    }

    @Override
    public UsuarioDto register(UsuarioDto usuarioDto) {
        verifyUsuarioExists(usuarioDto.getEmail());
        usuarioDto.setImagemUrl("http://unicietec.unievangelica.edu.br/wp-content/uploads/2017/04/avatar-placeholder-300x250.png");
        return save(usuarioDto);
    }

    @Override
    public UsuarioDto update(UsuarioEditDto usuarioDto) {
        var usuario = getLoggedUsuario();
        if (!Objects.equals(usuario.getEmail(), usuarioDto.getEmail())) {
            verifyUsuarioExists(usuarioDto.getEmail());
        }
        usuario.setFromUsuarioEdit(usuarioDto);
        usuario = repository.save(usuario);
        return mapEntityToDto(usuario);
    }

    @Override
    public void updateSenha(SenhaDto senhaDto) {
        var usuario = getLoggedUsuario();
        if (encoder.matches(senhaDto.getSenhaAtual(), usuario.getSenha())) {
            usuario.setSenha(encoder.encode(senhaDto.getNovaSenha()));
            repository.save(usuario);
        } else {
            throw new CurrentPasswordException();
        }
    }

    @Override
    public UsuarioDto getCurrent() {
        return mapEntityToDto(getLoggedUsuario());
    }

    @Override
    public UsuarioDto updateFavoritos(Long id) {
        var usuario = getLoggedUsuario();
        var favoritos = usuario.getFavoritosIds();
        if (favoritos.contains(id)) {
            favoritos.remove(id);
        } else {
            favoritos.add(id);
        }
        return mapEntityToDto(repository.save(usuario));
    }

    private void verifyUsuarioExists(String email) {
        if (repository.findByEmail(email).isPresent()) {
            throw new UserAlreadyRegisteredException();
        }
    }
}
