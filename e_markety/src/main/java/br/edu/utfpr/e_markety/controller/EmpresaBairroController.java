package br.edu.utfpr.e_markety.controller;

import br.edu.utfpr.e_markety.config.validator.CustomValidator;
import br.edu.utfpr.e_markety.dto.EmpresaBairroDto;
import br.edu.utfpr.e_markety.exceptions.BairroEmpresaAlreadyRegisteredException;
import br.edu.utfpr.e_markety.exceptions.BairroNotFoundForEmpresaException;
import br.edu.utfpr.e_markety.service.EmpresaBairroService;
import br.edu.utfpr.e_markety.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.constraints.NotNull;

@RestController
@RequestMapping("empresa-bairro")
@RequiredArgsConstructor
public class EmpresaBairroController extends GenericController<Long, EmpresaBairroDto> {

    private final EmpresaBairroService service;

    @Override
    protected GenericService<Long, EmpresaBairroDto> getService() {
        return service;
    }

    @GetMapping("/taxa/{id}")
    public ResponseEntity<?> getTaxaEntregaByBairro(@PathVariable @NotNull Long id) {
        try {
            return new ResponseEntity<>(service.findTaxaEntregaByBairroId(id), HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    @ExceptionHandler(BairroEmpresaAlreadyRegisteredException.class)
    public String handleValidationExceptions(BairroEmpresaAlreadyRegisteredException ex) {
        return CustomValidator.handleCustomRuntimeException(ex);
    }

    @ResponseStatus(HttpStatus.NOT_FOUND)
    @ExceptionHandler(BairroNotFoundForEmpresaException.class)
    public String handleValidationExceptions(BairroNotFoundForEmpresaException ex) {
        return CustomValidator.handleCustomRuntimeException(ex);
    }
}
