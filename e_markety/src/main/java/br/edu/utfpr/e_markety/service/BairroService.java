package br.edu.utfpr.e_markety.service;

import br.edu.utfpr.e_markety.model.Bairro;

import java.util.List;

public interface BairroService extends GenericService<Long, Bairro> {

    List<Bairro> getBairrosWithoutCurrentEmpresa();
}
