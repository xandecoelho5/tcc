package br.edu.utfpr.e_markety.repository;

import br.edu.utfpr.e_markety.model.Endereco;

public interface EnderecoRepository extends GenericUserRepository<Endereco, Long> {

    Endereco findEnderecoByUsuarioIdAndPadraoIsTrue(Long id);
}
