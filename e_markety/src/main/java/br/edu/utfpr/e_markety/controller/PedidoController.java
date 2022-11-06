package br.edu.utfpr.e_markety.controller;

import br.edu.utfpr.e_markety.dto.PageResponseDto;
import br.edu.utfpr.e_markety.model.Pedido;
import br.edu.utfpr.e_markety.service.GenericService;
import br.edu.utfpr.e_markety.service.PedidoService;
import br.edu.utfpr.e_markety.utils.PrincipalUtils;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("pedido")
@RequiredArgsConstructor
public class PedidoController extends GenericController<Long, Pedido> {
    private final PedidoService service;

    @Override
    protected GenericService<Long, Pedido> getService() {
        return service;
    }

    @PostMapping("/novo")
    public ResponseEntity<?> createPedido() {
        try {
            var usuario = PrincipalUtils.getLoggedUsuario();
            service.existsPendingPedidoByUsuarioId(usuario.getId());
            var registered = getService().save(new Pedido(usuario));

            return new ResponseEntity<>(registered, HttpStatus.CREATED);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }

    @GetMapping("/aberto")
    public ResponseEntity<?> getOpenPedido() {
        try {
            var usuario = PrincipalUtils.getLoggedUsuario();
            return new ResponseEntity<>(service.findOpenPedidoByUsuarioId(usuario.getId()), HttpStatus.OK);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }

    @GetMapping("/empresa/page")
    public ResponseEntity<PageResponseDto<Pedido>> getAllByEmpresa(@RequestParam int page,
                                                                   @RequestParam int size,
                                                                   @RequestParam(required = false) String order,
                                                                   @RequestParam(required = false) Boolean asc) {
        var paginatedData = service.findAllByEmpresa(getPageable(page, size, order, asc));
        return new ResponseEntity<>(PageResponseDto.of(paginatedData), HttpStatus.OK);
    }
}
