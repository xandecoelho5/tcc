package br.edu.utfpr.e_markety.service;

import br.edu.utfpr.e_markety.model.Endereco;

import java.util.List;

public interface EnderecoService extends GenericService<Endereco, Long, Endereco> {

    List<Endereco> findAllByUsuarioId(Long id);
    Endereco getDefaultAddress(Long id);
}
