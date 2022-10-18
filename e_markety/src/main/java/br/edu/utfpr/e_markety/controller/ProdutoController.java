package br.edu.utfpr.e_markety.controller;

import br.edu.utfpr.e_markety.model.Produto;
import br.edu.utfpr.e_markety.service.GenericService;
import br.edu.utfpr.e_markety.service.ProdutoService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.constraints.NotNull;
import java.util.List;

@RestController
@RequestMapping("produto")
@RequiredArgsConstructor
public class ProdutoController extends GenericController<Produto, Long, Produto> {
    private final ProdutoService service;

    @Override
    protected GenericService<Produto, Long, Produto> getService() {
        return service;
    }

    @GetMapping("categoria/{id}")
    public List<Produto> findAllByCategoriaId(@PathVariable @NotNull Long id) {
        return service.findAllByCategoriaId(id);
    }
}
