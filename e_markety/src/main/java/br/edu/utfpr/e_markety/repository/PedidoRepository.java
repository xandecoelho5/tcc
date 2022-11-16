package br.edu.utfpr.e_markety.repository;

import br.edu.utfpr.e_markety.model.Pedido;
import br.edu.utfpr.e_markety.model.enums.StatusPedido;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;

import javax.persistence.Tuple;
import java.util.List;

public interface PedidoRepository extends GenericUserRepository<Pedido, Long> {

    boolean existsByUsuarioIdAndStatusIs(Long usuarioId, StatusPedido status);

    List<Pedido> findAllByUsuarioIdAndStatusIsNot(Long usuarioId, StatusPedido status);

    Page<Pedido> findAllByUsuarioIdAndStatusIsNot(Long usuarioId, StatusPedido status, Pageable pageable);

    Page<Pedido> findAllByEmpresaIdAndStatusIsNot(Long id, StatusPedido status, Pageable pageable);

    Page<Pedido> findAllByEmpresaIdAndUsuarioId(Long empresaId, Long usuarioId, Pageable pageable);

    Pedido findByIdAndEmpresaId(Long id, Long empresaId);

    boolean existsByEnderecoId(Long id);

    // relatórios
    @Query(value = "select status, (count(status) * 1.0 / (select count(status) from pedido where empresa_id = :empresaId)) * 100 " +
            "  from pedido " +
            " where empresa_id = :empresaId " +
            " group by status", nativeQuery = true)
    List<Tuple> relatorioStatusPedidoByEmpresaId(Long empresaId);

    @Query(value = "SELECT * " +
            "  FROM pedido " +
            " WHERE empresa_id = :empresaId AND data_criacao between CURRENT_DATE - INTERVAL '1 YEAR' AND  CURRENT_DATE", nativeQuery = true)
    List<Pedido> findPedidosByDataCriacaoBetweenByEmpresaId(Long empresaId);
}
