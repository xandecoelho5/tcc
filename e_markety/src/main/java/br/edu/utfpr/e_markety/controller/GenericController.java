package br.edu.utfpr.e_markety.controller;

import br.edu.utfpr.e_markety.config.validator.CustomValidator;
import br.edu.utfpr.e_markety.service.GenericService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import java.util.List;
import java.util.Map;
import java.util.Optional;

public abstract class GenericController<T, ID, Y> {

    protected abstract GenericService<T, ID, Y> getService();

    @GetMapping
    public ResponseEntity<List<Y>> getAll() {
        return new ResponseEntity<>(getService().getAll(), HttpStatus.OK);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Y> getById(@PathVariable @NotNull ID id) {
        Optional<Y> dto = getService().getById(id);
        return dto.map(y -> new ResponseEntity<>(y, HttpStatus.OK)).orElseGet(() -> ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<?> save(@RequestBody @Valid Y dto) {
        Y registered = getService().save(dto);
        return new ResponseEntity<>(registered, HttpStatus.CREATED);
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> update(@PathVariable ID id, @RequestBody @Valid Y dto) {
        Optional<Y> updated = getService().update(id, dto);
        return updated.map(y -> new ResponseEntity<>(y, HttpStatus.OK)).orElseGet(() -> ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> delete(@PathVariable @NotNull ID id) {
        Optional<Boolean> wasDeleted = getService().delete(id);
        return wasDeleted.map(y -> ResponseEntity.noContent().build()).orElseGet(() -> ResponseEntity.notFound().build());
    }

    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public Map<String, String> handleValidationExceptions(MethodArgumentNotValidException ex) {
        return CustomValidator.handleMethodArgumentNotValidException(ex);
    }
}