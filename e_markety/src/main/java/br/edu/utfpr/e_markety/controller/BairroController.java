package br.edu.utfpr.e_markety.controller;

import br.edu.utfpr.e_markety.model.Bairro;
import br.edu.utfpr.e_markety.service.BairroService;
import br.edu.utfpr.e_markety.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("bairro")
@RequiredArgsConstructor
public class BairroController extends GenericController<Bairro, Long, Bairro> {

    private final BairroService service;

    @Override
    protected GenericService<Bairro, Long, Bairro> getService() {
        return service;
    }
}
