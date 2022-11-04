package br.edu.utfpr.e_markety.repository;

import br.edu.utfpr.e_markety.model.Endereco;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

public interface EnderecoRepository extends GenericUserRepository<Endereco, Long> {

    Endereco findEnderecoByUsuarioIdAndPadraoIsTrue(Long id);

    @Modifying
    @Query("update Endereco e set e.padrao = false where e.usuario.id = :id")
    void updateAllEnderecosToNotDefault(Long id);

}
