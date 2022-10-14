package br.edu.utfpr.e_markety.controller;

import br.edu.utfpr.e_markety.model.Endereco;
import br.edu.utfpr.e_markety.service.EnderecoService;
import br.edu.utfpr.e_markety.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("endereco")
@RequiredArgsConstructor
public class EnderecoController extends GenericController<Endereco, Long, Endereco> {
    private final EnderecoService service;

    @Override
    protected GenericService<Endereco, Long, Endereco> getService() {
        return service;
    }
}
