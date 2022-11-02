package br.edu.utfpr.e_markety.controller;

import br.edu.utfpr.e_markety.config.validator.CustomValidator;
import br.edu.utfpr.e_markety.dto.PageResponseDto;
import br.edu.utfpr.e_markety.exceptions.ExistsLinkedDataException;
import br.edu.utfpr.e_markety.exceptions.InvalidLoggedUserException;
import br.edu.utfpr.e_markety.exceptions.NotFoundException;
import br.edu.utfpr.e_markety.service.GenericService;
import br.edu.utfpr.e_markety.utils.UserUtils;
import org.springframework.data.domain.PageRequest;
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

        var result = this.getService().getAll(PageRequest.of(0, pageSize));
        return new ResponseEntity<>(result.toList(), HttpStatus.OK);
    }

    @GetMapping("page")
    public ResponseEntity<PageResponseDto<Y>> getAll(@RequestParam int page,
                                                     @RequestParam int size,
                                                     @RequestParam(required = false) String order,
                                                     @RequestParam(required = false) Boolean asc) {
        var pageRequest = PageRequest.of(page, size);

        if (order != null && asc != null) {
            pageRequest = PageRequest.of(page, size, asc ? Sort.Direction.ASC : Sort.Direction.DESC, order);
        }
        var paginatedData = getService().getAll(pageRequest);

        return new ResponseEntity<>(PageResponseDto.of(paginatedData), HttpStatus.OK);
    }

    @GetMapping("/current")
    public ResponseEntity<?> getAllByCurrentUser() {
        try {
            var user = UserUtils.getLoggedUser();
            return new ResponseEntity<>(getService().getAllByCurrentUser((ID) user.getId()), HttpStatus.OK);
        } catch (InvalidLoggedUserException e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.UNAUTHORIZED);
        } catch (UnsupportedOperationException e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_FOUND);
        }
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getById(@PathVariable @NotNull ID id) {
        try {
            var entity = getService().getById(id);
            return new ResponseEntity<>(entity, HttpStatus.OK);
        } catch (NotFoundException e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_FOUND);
        }
    }

    @PostMapping
    public ResponseEntity<?> save(@RequestBody @Valid Y dto) {
        Y registered = getService().save(dto);
        return new ResponseEntity<>(registered, HttpStatus.CREATED);
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> update(@PathVariable ID id, @RequestBody @Valid Y dto) {
        try {
            var updated = getService().update(id, dto);
            return new ResponseEntity<>(updated, HttpStatus.OK);
        } catch (NotFoundException e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_FOUND);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> delete(@PathVariable @NotNull ID id) {
        try {
            getService().delete(id);
            return ResponseEntity.noContent().build();
        } catch (NotFoundException e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_FOUND);
        } catch (ExistsLinkedDataException e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public Map<String, String> handleValidationExceptions(MethodArgumentNotValidException ex) {
        return CustomValidator.handleMethodArgumentNotValidException(ex);
    }
}
