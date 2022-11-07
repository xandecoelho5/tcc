package br.edu.utfpr.e_markety.repository;

import br.edu.utfpr.e_markety.model.Pedido;
import br.edu.utfpr.e_markety.model.enums.StatusPedido;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface PedidoRepository extends GenericUserRepository<Pedido, Long> {

    boolean existsByUsuarioIdAndStatusIs(Long usuarioId, StatusPedido status);

    List<Pedido> findAllByUsuarioIdAndStatusIsNot(Long usuarioId, StatusPedido status);

    Page<Pedido> findAllByUsuarioIdAndStatusIsNot(Long usuarioId, StatusPedido status, Pageable pageable);

    Page<Pedido> findAllByEmpresaId(Long id, Pageable pageable);

    Page<Pedido> findAllByEmpresaIdAndUsuarioId(Long empresaId, Long usuarioId, Pageable pageable);

    Pedido findByIdAndEmpresaId(Long id, Long empresaId);

    boolean existsByEnderecoId(Long id);
}
