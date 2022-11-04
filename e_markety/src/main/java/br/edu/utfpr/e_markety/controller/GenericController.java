package br.edu.utfpr.e_markety.controller;

import br.edu.utfpr.e_markety.config.validator.CustomValidator;
import br.edu.utfpr.e_markety.dto.PageResponseDto;
import br.edu.utfpr.e_markety.exceptions.ExistsLinkedDataException;
import br.edu.utfpr.e_markety.exceptions.InvalidLoggedUserException;
import br.edu.utfpr.e_markety.exceptions.NotFoundException;
import br.edu.utfpr.e_markety.service.GenericService;
import br.edu.utfpr.e_markety.utils.PrincipalUtils;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import java.util.List;
import java.util.Map;
import java.util.Optional;

public abstract class GenericController<ID, Y> {

    protected abstract GenericService<ID, Y> getService();

    @GetMapping
    public ResponseEntity<List<Y>> getAll(@RequestParam("size") Optional<Integer> size) {
        if (size.isPresent() && size.get() == 0) {
            return ResponseEntity.ok(getService().getAll());
        }

        int pageSize = size.orElse(5);

        var result = getService().getAll(PageRequest.of(0, pageSize));
        return new ResponseEntity<>(result.toList(), HttpStatus.OK);
    }

    @GetMapping("/page")
    public ResponseEntity<PageResponseDto<Y>> getAllPaginated(@RequestParam int page,
                                                              @RequestParam int size,
                                                              @RequestParam(required = false) String order,
                                                              @RequestParam(required = false) Boolean asc) {
        var paginatedData = getService().getAll(getPageable(page, size, order, asc));
        return new ResponseEntity<>(PageResponseDto.of(paginatedData), HttpStatus.OK);
    }

    protected Pageable getPageable(int page, int size, String order, Boolean asc) {
        var pageRequest = PageRequest.of(page, size);

        if (order != null && asc != null) {
            pageRequest = PageRequest.of(page, size, asc ? Sort.Direction.ASC : Sort.Direction.DESC, order);
        }

        return pageRequest;
    }

    @GetMapping("/{id}")
    public ResponseEntity<Y> getById(@PathVariable @NotNull ID id) {
        var entity = getService().getById(id);
        return new ResponseEntity<>(entity, HttpStatus.OK);
    }

    @PostMapping
    public ResponseEntity<Y> save(@RequestBody @Valid Y dto) {
        Y registered = getService().save(dto);
        return new ResponseEntity<>(registered, HttpStatus.CREATED);
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> update(@PathVariable ID id, @RequestBody @Valid Y dto) {
        try {
            var updated = getService().update(id, dto);
            return new ResponseEntity<>(updated, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> delete(@PathVariable @NotNull ID id) {
        try {
            getService().delete(id);
            return ResponseEntity.noContent().build();
        } catch (ExistsLinkedDataException e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public Map<String, String> handleValidationExceptions(MethodArgumentNotValidException ex) {
        return CustomValidator.handleMethodArgumentNotValidException(ex);
    }

    @ResponseStatus(HttpStatus.UNAUTHORIZED)
    @ExceptionHandler(InvalidLoggedUserException.class)
    public String handleValidationExceptions(InvalidLoggedUserException ex) {
        return CustomValidator.handleCustomRuntimeException(ex);
    }

    @ResponseStatus(HttpStatus.NOT_FOUND)
    @ExceptionHandler(NotFoundException.class)
    public String handleValidationExceptions(NotFoundException ex) {
        return CustomValidator.handleCustomRuntimeException(ex);
    }
}
