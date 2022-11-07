package br.edu.utfpr.e_markety.service;

import br.edu.utfpr.e_markety.dto.PedidoDto;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface PedidoService extends GenericService<Long, PedidoDto> {

    PedidoDto findOpenPedidoByUsuario();

    Page<PedidoDto> findAllByEmpresa(Pageable pageable);

    PedidoDto findByIdAndEmpresa(Long id);

    PedidoDto createPedido();
}
