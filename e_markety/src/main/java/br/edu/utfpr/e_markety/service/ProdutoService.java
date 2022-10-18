package br.edu.utfpr.e_markety.service;

import br.edu.utfpr.e_markety.model.Produto;

import java.util.List;

public interface ProdutoService extends GenericService<Produto, Long, Produto> {

    List<Produto> findAllByCategoriaId(Long id);
}
