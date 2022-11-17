package br.edu.utfpr.e_markety.controller;

import br.edu.utfpr.e_markety.model.UnidadeMedida;
import br.edu.utfpr.e_markety.service.GenericService;
import br.edu.utfpr.e_markety.service.UnidadeMedidaService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("unidade-medida")
@RequiredArgsConstructor
public class UnidadeMedidaController extends GenericController<Long, UnidadeMedida> {
    private final UnidadeMedidaService service;

    @Override
    protected GenericService<Long, UnidadeMedida> getService() {
        return service;
    }
}
