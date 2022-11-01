package br.edu.utfpr.e_markety.repository;

import br.edu.utfpr.e_markety.model.PedidoItem;

public interface PedidoItemRepository extends GenericRepository<PedidoItem, Long> {

    boolean existsByProdutoId(Long id);
}
