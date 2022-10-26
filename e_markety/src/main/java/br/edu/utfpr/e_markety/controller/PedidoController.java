package br.edu.utfpr.e_markety.controller;

import br.edu.utfpr.e_markety.exceptions.InvalidLoggedUserException;
import br.edu.utfpr.e_markety.model.Pedido;
import br.edu.utfpr.e_markety.service.GenericService;
import br.edu.utfpr.e_markety.service.PedidoService;
import br.edu.utfpr.e_markety.utils.UserUtils;
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

    @PostMapping("novo")
    public ResponseEntity<?> createOrder() {
        try {
            var user = UserUtils.getLoggedUser();
            service.existsPendingPedidoByUsuarioId(user.getId());
            var registered = getService().save(new Pedido(user));

            return new ResponseEntity<>(registered, HttpStatus.CREATED);
        } catch (InvalidLoggedUserException e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(e.getMessage());
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }

    @GetMapping("aberto")
    public ResponseEntity<?> getOpenOrder() {
        try {
            var user = UserUtils.getLoggedUser();
            return new ResponseEntity<>(service.findOpenPedidoByUsuarioId(user.getId()), HttpStatus.OK);
        } catch (InvalidLoggedUserException e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(e.getMessage());
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }
}
