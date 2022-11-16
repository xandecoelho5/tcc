package br.edu.utfpr.e_markety.service;

import br.edu.utfpr.e_markety.dto.PedidoDto;
import br.edu.utfpr.e_markety.dto.relatorios.PedidosMes;
import br.edu.utfpr.e_markety.dto.relatorios.ResumoStatus;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface PedidoService extends GenericService<Long, PedidoDto> {

    PedidoDto findOpenPedidoByUsuario();

    Page<PedidoDto> findAllByEmpresa(Pageable pageable);

    PedidoDto createPedido();

    void updatePedidoStatus(Long id);

    // relatórios
    List<ResumoStatus> relatorioStatusPedido();

    List<PedidosMes> findPedidosByDataCriacaoBetween();
}
