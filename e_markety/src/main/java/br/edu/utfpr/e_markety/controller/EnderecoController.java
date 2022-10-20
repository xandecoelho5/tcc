package br.edu.utfpr.e_markety.controller;

import br.edu.utfpr.e_markety.exceptions.InvalidLoggedUserException;
import br.edu.utfpr.e_markety.exceptions.NoneDefaultAddressFoundException;
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

@RestController
@RequestMapping("endereco")
@RequiredArgsConstructor
public class EnderecoController extends GenericController<Long, Endereco> {
    private final EnderecoService service;

    @Override
    protected GenericService<Long, Endereco> getService() {
        return service;
    }

    @GetMapping("padrao")
    public ResponseEntity<?> getDefaultAddress() {
        try {
            var user = UserUtils.getLoggedUser();
            var defaultAddress = service.getDefaultAddress(user.getId());
            return new ResponseEntity<>(defaultAddress, HttpStatus.OK);
        } catch (InvalidLoggedUserException e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.UNAUTHORIZED);
        } catch (NoneDefaultAddressFoundException e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_FOUND);
        }
    }
}
