package br.edu.utfpr.e_markety.service;

import br.edu.utfpr.e_markety.dto.FiltroDto;
import br.edu.utfpr.e_markety.dto.PedidoItemDto;
import br.edu.utfpr.e_markety.dto.PrecoDto;
import br.edu.utfpr.e_markety.dto.ProdutoDto;
import br.edu.utfpr.e_markety.dto.relatorios.VendaProdutos;

import java.util.List;

public interface ProdutoService extends GenericService<Long, ProdutoDto> {

    List<ProdutoDto> findAllByCategoriaId(Long id);

    List<ProdutoDto> findAllByIdIn(List<Long> ids);

    List<ProdutoDto> findAllByFilter(FiltroDto filtro);

    void validateProdutosEstoque(List<PedidoItemDto> dtos);

    PrecoDto findMinAndMaxPreco();

    // relatórios
    List<VendaProdutos> relatorioVendaProdutos(String sort);
}
