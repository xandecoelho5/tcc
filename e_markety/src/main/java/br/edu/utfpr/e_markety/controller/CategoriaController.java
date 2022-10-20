package br.edu.utfpr.e_markety.controller;

import br.edu.utfpr.e_markety.model.Categoria;
import br.edu.utfpr.e_markety.service.CategoriaService;
import br.edu.utfpr.e_markety.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("categoria")
@RequiredArgsConstructor
public class CategoriaController extends GenericController<Long, Categoria> {
    private final CategoriaService service;

    @Override
    protected GenericService<Long, Categoria> getService() {
        return service;
    }
}
