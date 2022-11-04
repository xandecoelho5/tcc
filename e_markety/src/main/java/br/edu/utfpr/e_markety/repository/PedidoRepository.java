package br.edu.utfpr.e_markety.repository;

import br.edu.utfpr.e_markety.model.Pedido;
import br.edu.utfpr.e_markety.model.enums.StatusPedido;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface PedidoRepository extends GenericUserRepository<Pedido, Long> {

    boolean existsByUsuarioIdAndStatusIs(Long usuarioId, StatusPedido status);

    List<Pedido> findAllByUsuarioIdAndStatusIsNot(Long usuarioId, StatusPedido status);

    Page<Pedido> findAllByUsuarioIdAndStatusIsNot(Long usuarioId, StatusPedido status, Pageable pageable);

    @Query("select distinct p " +
            "from Pedido p " +
            "inner join p.items i " +
            "inner join i.produto pr " +
            "inner join pr.empresa e " +
            "where e.id = :id")
    Page<Pedido> findAllByEmpresaId(Long id, Pageable pageable);

    @Query("select distinct p " +
            "from Pedido p " +
            "inner join p.items i " +
            "inner join i.produto pr " +
            "inner join pr.empresa e " +
            "where e.id = :empresaId and p.usuario.id = :usuarioId")
    Page<Pedido> findAllByEmpresaIdAndUsuarioId(Long empresaId, Long usuarioId, Pageable pageable);
}
