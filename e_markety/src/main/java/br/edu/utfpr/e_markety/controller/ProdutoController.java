package br.edu.utfpr.e_markety.controller;

import br.edu.utfpr.e_markety.dto.FiltroDto;
import br.edu.utfpr.e_markety.dto.PageResponseDto;
import br.edu.utfpr.e_markety.dto.ProdutoDto;
import br.edu.utfpr.e_markety.service.GenericService;
import br.edu.utfpr.e_markety.service.ProdutoService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.constraints.NotNull;
import java.util.List;

@RestController
@RequestMapping("produto")
@RequiredArgsConstructor
public class ProdutoController extends GenericController<Long, ProdutoDto> {
    private final ProdutoService service;

    @Override
    protected GenericService<Long, ProdutoDto> getService() {
        return service;
    }

    @GetMapping("categoria/{id}")
    public List<ProdutoDto> findAllByCategoriaId(@PathVariable @NotNull Long id) {
        return service.findAllByCategoriaId(id);
    }

    @PostMapping("filtro")
    public List<ProdutoDto> findAllByFilter(@RequestBody FiltroDto filtro) {
        System.out.println(filtro);
        return service.findAllByFilter(filtro.getNome(), filtro.getCategoriaId(), filtro.getPrecoMin(),
                filtro.getPrecoMax(), filtro.getTipoOrdenacao().getSort());
    }

    @GetMapping("page")
    public ResponseEntity<PageResponseDto<ProdutoDto>> getAll(@RequestParam int page,
                                                              @RequestParam int size,
                                                              @RequestParam(required = false) String order,
                                                              @RequestParam(required = false) Boolean asc) {
        var pageRequest = PageRequest.of(page, size);

        if (order != null && asc != null) {
            pageRequest = PageRequest.of(page, size, asc ? Sort.Direction.ASC : Sort.Direction.DESC, order);
        }
        var produtoPage = getService().getAll(pageRequest);

        return new ResponseEntity<>(PageResponseDto.of(produtoPage), HttpStatus.OK);
    }
}
