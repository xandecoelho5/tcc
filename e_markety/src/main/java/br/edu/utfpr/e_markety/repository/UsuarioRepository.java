package br.edu.utfpr.e_markety.repository;

import br.edu.utfpr.e_markety.model.Usuario;

import java.util.Optional;

public interface UsuarioRepository extends GenericRepository<Usuario, Long> {

    Optional<Usuario> findByEmail(String email);
}
