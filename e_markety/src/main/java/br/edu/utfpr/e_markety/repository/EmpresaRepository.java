package br.edu.utfpr.e_markety.repository;

import br.edu.utfpr.e_markety.model.Empresa;
import org.springframework.data.jpa.repository.Query;

import java.util.Optional;

public interface EmpresaRepository extends GenericRepository<Empresa, Long> {

    boolean existsByEnderecoId(Long id);

    @Query("SELECT e FROM Empresa e WHERE e.endereco.usuario.email = ?1")
    Optional<Empresa> findByUsuarioEmail(String email);
}
