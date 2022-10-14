package br.edu.utfpr.e_markety.service.impl;

import br.edu.utfpr.e_markety.model.Pedido;
import br.edu.utfpr.e_markety.repository.GenericRepository;
import br.edu.utfpr.e_markety.repository.PedidoRepository;
import br.edu.utfpr.e_markety.service.PedidoService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class PedidoServiceImpl extends GenericServiceImpl<Pedido, Long, Pedido> implements PedidoService {

    private final PedidoRepository repository;

    @Override
    protected GenericRepository<Pedido, Long> getRepository() {
        return repository;
    }
}
