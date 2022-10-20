package br.edu.utfpr.e_markety.controller;

import br.edu.utfpr.e_markety.model.Pedido;
import br.edu.utfpr.e_markety.service.GenericService;
import br.edu.utfpr.e_markety.service.PedidoService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("pedido")
@RequiredArgsConstructor
public class PedidoController extends GenericController<Long, Pedido> {
    private final PedidoService service;

    @Override
    protected GenericService<Long, Pedido> getService() {
        return service;
    }
}
