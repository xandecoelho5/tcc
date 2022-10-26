package br.edu.utfpr.e_markety.repository;

import br.edu.utfpr.e_markety.model.Pedido;
import br.edu.utfpr.e_markety.model.enums.StatusPedido;

import java.util.List;
import java.util.Optional;

public interface PedidoRepository extends GenericUserRepository<Pedido, Long> {

    boolean existsByUsuarioIdAndStatusIs(Long usuarioId, StatusPedido status);

    List<Pedido> findAllByUsuarioIdAndStatusIsNot(Long usuarioId, StatusPedido status);

    Optional<Pedido> findByUsuarioIdAndStatusIs(Long usuarioId, StatusPedido status);
}
