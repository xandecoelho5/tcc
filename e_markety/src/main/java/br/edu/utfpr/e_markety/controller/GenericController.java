package br.edu.utfpr.e_markety.controller;

import br.edu.utfpr.e_markety.config.validator.CustomValidator;
import br.edu.utfpr.e_markety.exceptions.InvalidLoggedUserException;
import br.edu.utfpr.e_markety.service.GenericService;
import br.edu.utfpr.e_markety.utils.UserUtils;
import org.springframework.data.domain.PageRequest;
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
    public ResponseEntity<List<Y>> getAll(@RequestParam("page") Optional<Integer> page, @RequestParam("size") Optional<Integer> size) {
        if (size.isPresent() && size.get() == 0) {
            return ResponseEntity.ok(getService().getAll());
        }

        int currentPage = page.orElse(1);
        int pageSize = size.orElse(5);

        var result = this.getService().getAll(PageRequest.of(currentPage - 1, pageSize));
//        if (list.getTotalPages() > 0) {
//            List<Integer> pageNumbers = IntStream.rangeClosed(1, list.getTotalPages()).boxed().toList();
//        }
        return new ResponseEntity<>(result.toList(), HttpStatus.OK);
    }

    @GetMapping("/current")
    public ResponseEntity<?> getAllByCurrentUser() {
        try {
            var user = UserUtils.getLoggedUser();
            return new ResponseEntity<>(getService().getAllByCurrentUser((ID)user.getId()), HttpStatus.OK);
        } catch (InvalidLoggedUserException e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.UNAUTHORIZED);
        } catch (UnsupportedOperationException e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_FOUND);
        }
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
