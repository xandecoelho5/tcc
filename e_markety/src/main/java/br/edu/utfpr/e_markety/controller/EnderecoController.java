package br.edu.utfpr.e_markety.controller;

import br.edu.utfpr.e_markety.exceptions.NoneDefaultAddressFoundException;
import br.edu.utfpr.e_markety.model.Endereco;
import br.edu.utfpr.e_markety.service.EnderecoService;
import br.edu.utfpr.e_markety.service.GenericService;
import br.edu.utfpr.e_markety.utils.PrincipalUtils;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.constraints.NotNull;

@RestController
@RequestMapping("endereco")
@RequiredArgsConstructor
public class EnderecoController extends GenericController<Long, Endereco> {
    private final EnderecoService service;

    @Override
    protected GenericService<Long, Endereco> getService() {
        return service;
    }

    @GetMapping("/padrao")
    public ResponseEntity<?> getDefaultEndereco() {
        try {
            var usuario = PrincipalUtils.getLoggedUsuario();
            var defaultEndereco = service.getDefaultEndereco(usuario.getId());
            return new ResponseEntity<>(defaultEndereco, HttpStatus.OK);
        } catch (NoneDefaultAddressFoundException e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_FOUND);
        }
    }

    @Override
    @DeleteMapping("/{id}")
    public ResponseEntity<?> delete(@PathVariable @NotNull Long id) {
        try {
            return super.delete(id);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
