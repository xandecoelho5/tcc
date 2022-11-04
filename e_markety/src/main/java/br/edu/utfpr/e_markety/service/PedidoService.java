package br.edu.utfpr.e_markety.service;

import br.edu.utfpr.e_markety.model.Pedido;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface PedidoService extends GenericService<Long, Pedido> {

    void existsPendingPedidoByUsuarioId(Long usuarioId);

    Pedido findOpenPedidoByUsuarioId(Long usuarioId);

    Page<Pedido> findAllByEmpresa(Pageable pageable);
}
