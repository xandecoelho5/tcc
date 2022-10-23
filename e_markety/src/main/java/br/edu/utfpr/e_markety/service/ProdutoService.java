package br.edu.utfpr.e_markety.service;

import br.edu.utfpr.e_markety.model.Produto;
import org.springframework.data.domain.Sort;

import java.math.BigDecimal;
import java.util.List;

public interface ProdutoService extends GenericService<Long, Produto> {

    List<Produto> findAllByCategoriaId(Long id);

    List<Produto> findAllByIdIn(List<Long> ids);

    List<Produto> findAllByFilter(String nome, Long categoriaId, BigDecimal precoMin, BigDecimal precoMax, Sort sort);
}
