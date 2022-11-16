package br.edu.utfpr.e_markety.service;

import br.edu.utfpr.e_markety.dto.PedidoItemDto;
import br.edu.utfpr.e_markety.dto.PrecoDto;
import br.edu.utfpr.e_markety.dto.ProdutoDto;
import br.edu.utfpr.e_markety.dto.relatorios.VendaProdutos;
import org.springframework.data.domain.Sort;

import java.math.BigDecimal;
import java.util.List;

public interface ProdutoService extends GenericService<Long, ProdutoDto> {

    List<ProdutoDto> findAllByCategoriaId(Long id);

    List<ProdutoDto> findAllByIdIn(List<Long> ids);

    List<ProdutoDto> findAllByFilter(String nome, Long categoriaId, BigDecimal precoMin, BigDecimal precoMax, Sort sort);

    void validateProdutosEstoque(List<PedidoItemDto> dtos);

    PrecoDto findMinAndMaxPreco();

    // relatórios
    List<VendaProdutos> relatorioVendaProdutos(String sort);
}
