package br.edu.utfpr.e_markety.controller;

import br.edu.utfpr.e_markety.dto.FiltroDto;
import br.edu.utfpr.e_markety.model.Produto;
import br.edu.utfpr.e_markety.service.GenericService;
import br.edu.utfpr.e_markety.service.ProdutoService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import javax.validation.constraints.NotNull;
import java.util.List;

@RestController
@RequestMapping("produto")
@RequiredArgsConstructor
public class ProdutoController extends GenericController<Long, Produto> {
    private final ProdutoService service;

    @Override
    protected GenericService<Long, Produto> getService() {
        return service;
    }

    @GetMapping("categoria/{id}")
    public List<Produto> findAllByCategoriaId(@PathVariable @NotNull Long id) {
        return service.findAllByCategoriaId(id);
    }

    @PostMapping("filtro")
    public List<Produto> findAllByFilter(@RequestBody FiltroDto filtro) {
        System.out.println(filtro);
        return service.findAllByFilter(filtro.getNome(), filtro.getCategoriaId(), filtro.getPrecoMin(),
                filtro.getPrecoMax(), filtro.getTipoOrdenacao().getSort());
    }
}
