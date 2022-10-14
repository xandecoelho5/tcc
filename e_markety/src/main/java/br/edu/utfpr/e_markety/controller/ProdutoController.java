package br.edu.utfpr.e_markety.controller;

import br.edu.utfpr.e_markety.model.Produto;
import br.edu.utfpr.e_markety.service.GenericService;
import br.edu.utfpr.e_markety.service.ProdutoService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("produto")
@RequiredArgsConstructor
public class ProdutoController extends GenericController<Produto, Long, Produto> {
    private final ProdutoService service;

    @Override
    protected GenericService<Produto, Long, Produto> getService() {
        return service;
    }
}
