package br.edu.utfpr.e_markety.controller;

import br.edu.utfpr.e_markety.dto.PageResponseDto;
import br.edu.utfpr.e_markety.dto.PedidoDto;
import br.edu.utfpr.e_markety.service.GenericService;
import br.edu.utfpr.e_markety.service.PedidoService;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;

@RestController
@RequestMapping("pedido")
public class PedidoController extends GenericController<Long, PedidoDto> {

    private final PedidoService service;

    public PedidoController(PedidoService service) {
        sort = Sort.by("id").descending();
        this.service = service;
    }

    @Override
    protected GenericService<Long, PedidoDto> getService() {
        return service;
    }

    @PostMapping("/novo")
    public ResponseEntity<?> createPedido() {
        try {
            return new ResponseEntity<>(service.createPedido(), HttpStatus.CREATED);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }

    @GetMapping("/aberto")
    public ResponseEntity<?> getOpenPedido() {
        try {
            return new ResponseEntity<>(service.findOpenPedidoByUsuario(), HttpStatus.OK);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }

    @PutMapping("/realizar")
    public ResponseEntity<?> placePedido(@RequestBody @Valid PedidoDto pedidoDto) {
        try {
            return new ResponseEntity<>(service.update(pedidoDto.getId(), pedidoDto), HttpStatus.OK);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }

    @GetMapping("/empresa/page")
    public ResponseEntity<PageResponseDto<PedidoDto>> getAllByEmpresa(@RequestParam int page,
                                                                      @RequestParam int size,
                                                                      @RequestParam(required = false) String order,
                                                                      @RequestParam(required = false) Boolean asc) {
        var paginatedData = service.findAllByEmpresa(getPageable(page, size, order, asc));
        return new ResponseEntity<>(PageResponseDto.of(paginatedData), HttpStatus.OK);
    }

    @Transactional
    @PatchMapping("/{id}")
    public ResponseEntity<?> updatePedidoStatus(@PathVariable @NotNull Long id) {
        try {
            service.updatePedidoStatus(id);
            return new ResponseEntity<>(HttpStatus.OK);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }
}
