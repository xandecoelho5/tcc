package br.edu.utfpr.e_markety.controller;

import br.edu.utfpr.e_markety.model.Empresa;
import br.edu.utfpr.e_markety.service.EmpresaService;
import br.edu.utfpr.e_markety.service.GenericService;
import br.edu.utfpr.e_markety.utils.PrincipalUtils;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.constraints.NotNull;

@RestController
@RequestMapping("empresa")
@RequiredArgsConstructor
public class EmpresaController extends GenericController<Long, Empresa> {
    private final EmpresaService service;

    @Override
    protected GenericService<Long, Empresa> getService() {
        return service;
    }

    @GetMapping("current")
    public ResponseEntity<Empresa> getCurrentEmpresa() {
        var empresa = PrincipalUtils.getLoggedEmpresa();
        return new ResponseEntity<>(empresa, HttpStatus.OK);
    }

    @GetMapping("/bairro")
    public ResponseEntity<?> getBairros() {
        try {
            var bairros = service.findAllBairros();
            return new ResponseEntity<>(bairros, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    @GetMapping("/bairro/taxa/{id}")
    public ResponseEntity<?> getTaxaEntregaOfBairro(@PathVariable @NotNull Long id) {
        try {
            var taxaEntrega = service.findTaxaEntregaByBairroId(id);
            return new ResponseEntity<>(taxaEntrega, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }
}
