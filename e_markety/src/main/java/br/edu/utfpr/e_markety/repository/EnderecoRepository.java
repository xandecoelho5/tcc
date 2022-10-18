package br.edu.utfpr.e_markety.repository;

import br.edu.utfpr.e_markety.model.Endereco;

import java.util.List;

public interface EnderecoRepository extends GenericRepository<Endereco, Long> {

    List<Endereco> findAllByUsuarioId(Long id);
    Endereco findEnderecoByUsuarioIdAndPadraoIsTrue(Long id);
}
