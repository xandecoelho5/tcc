package br.edu.utfpr.e_markety.controller;

import br.edu.utfpr.e_markety.model.Endereco;
import br.edu.utfpr.e_markety.service.EnderecoService;
import br.edu.utfpr.e_markety.service.GenericService;
import br.edu.utfpr.e_markety.utils.UserUtils;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("endereco")
@RequiredArgsConstructor
public class EnderecoController extends GenericController<Endereco, Long, Endereco> {
    private final EnderecoService service;

    @Override
    protected GenericService<Endereco, Long, Endereco> getService() {
        return service;
    }

    @Override
    public ResponseEntity<List<Endereco>> getAll(Optional<Integer> page, Optional<Integer> size) {
        var optionalUser = UserUtils.getLoggedUser();
        if (optionalUser.isEmpty()) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
        return new ResponseEntity<>(service.findAllByUsuarioId(optionalUser.get().getId()), HttpStatus.OK);
    }

    @GetMapping("padrao")
    public ResponseEntity<?> getDefaultAddress() {
        var optionalUser = UserUtils.getLoggedUser();
        if (optionalUser.isEmpty()) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }

        var endereco = service.getDefaultAddress(optionalUser.get().getId());
        if (endereco == null) {
            return new ResponseEntity<>("Não existe endereço padrão cadastrado.", HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<>(endereco, HttpStatus.OK);
    }
}
