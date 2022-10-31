package br.edu.utfpr.e_markety.service;

import br.edu.utfpr.e_markety.dto.ProdutoDto;
import org.springframework.data.domain.Sort;

import java.math.BigDecimal;
import java.util.List;

public interface ProdutoService extends GenericService<Long, ProdutoDto> {

    List<ProdutoDto> findAllByCategoriaId(Long id);

    List<ProdutoDto> findAllByIdIn(List<Long> ids);

    List<ProdutoDto> findAllByFilter(String nome, Long categoriaId, BigDecimal precoMin, BigDecimal precoMax, Sort sort);
}
