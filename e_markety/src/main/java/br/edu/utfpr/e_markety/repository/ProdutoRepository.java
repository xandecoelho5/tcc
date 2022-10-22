package br.edu.utfpr.e_markety.repository;

import br.edu.utfpr.e_markety.model.Produto;

import java.util.List;

public interface ProdutoRepository extends GenericRepository<Produto, Long> {

    List<Produto> findAllByCategoriaId(Long id);

    List<Produto> findAllByIdIn(List<Long> ids);
}
