package br.edu.utfpr.e_markety.service.impl;

import br.edu.utfpr.e_markety.model.PedidoItem;
import br.edu.utfpr.e_markety.repository.GenericRepository;
import br.edu.utfpr.e_markety.repository.PedidoItemRepository;
import br.edu.utfpr.e_markety.service.PedidoItemService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class PedidoItemServiceImpl extends GenericServiceImpl<PedidoItem, Long, PedidoItem> implements PedidoItemService {

    private final PedidoItemRepository repository;

    @Override
    protected GenericRepository<PedidoItem, Long> getRepository() {
        return repository;
    }
}
