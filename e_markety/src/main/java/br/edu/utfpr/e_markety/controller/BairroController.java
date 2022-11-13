package br.edu.utfpr.e_markety.controller;

import br.edu.utfpr.e_markety.model.Bairro;
import br.edu.utfpr.e_markety.service.BairroService;
import br.edu.utfpr.e_markety.service.GenericService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("bairro")
@RequiredArgsConstructor
public class BairroController extends GenericController<Long, Bairro> {

    private final BairroService service;

    @Override
    protected GenericService<Long, Bairro> getService() {
        return service;
    }

    @GetMapping("/sem-empresa-atual")
    public ResponseEntity<?> getBairrosWithoutCurrentEmpresa() {
        try {
            return new ResponseEntity<>(service.getBairrosWithoutCurrentEmpresa(), HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

}
