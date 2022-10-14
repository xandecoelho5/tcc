package br.edu.utfpr.e_markety.controller;

import br.edu.utfpr.e_markety.model.PedidoItem;
import br.edu.utfpr.e_markety.service.GenericService;
import br.edu.utfpr.e_markety.service.PedidoItemService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("pedido-item")
@RequiredArgsConstructor
public class PedidoItemController extends GenericController<PedidoItem, Long, PedidoItem> {
    private final PedidoItemService service;

    @Override
    protected GenericService<PedidoItem, Long, PedidoItem> getService() {
        return service;
    }
}
