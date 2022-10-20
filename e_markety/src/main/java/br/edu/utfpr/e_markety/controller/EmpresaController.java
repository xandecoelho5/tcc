package br.edu.utfpr.e_markety.controller;

import br.edu.utfpr.e_markety.model.Empresa;
import br.edu.utfpr.e_markety.service.EmpresaService;
import br.edu.utfpr.e_markety.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("empresa")
@RequiredArgsConstructor
public class EmpresaController extends GenericController<Long, Empresa> {
    private final EmpresaService service;

    @Override
    protected GenericService<Long, Empresa> getService() {
        return service;
    }
}
