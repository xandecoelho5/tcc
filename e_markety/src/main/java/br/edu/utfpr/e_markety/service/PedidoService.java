package br.edu.utfpr.e_markety.service;

import br.edu.utfpr.e_markety.model.Pedido;

public interface PedidoService extends GenericService<Long, Pedido> {

    void existsPendingPedidoByUsuarioId(Long usuarioId);

    Pedido findOpenPedidoByUsuarioId(Long usuarioId);
}
