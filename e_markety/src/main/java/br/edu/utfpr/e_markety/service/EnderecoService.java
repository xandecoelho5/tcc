package br.edu.utfpr.e_markety.service;

import br.edu.utfpr.e_markety.model.Endereco;

public interface EnderecoService extends GenericService<Long, Endereco> {

    Endereco getDefaultEndereco(Long id);
}
