package br.edu.utfpr.e_markety.service;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Optional;

public interface GenericService <T, ID, Y> {

    List<Y> getAll();

    Page<Y> getAll(Pageable pageable);

    Y save(Y dto);

    Optional<Y> update(ID id, Y dto);

    Optional<Y> getById(ID id);

    Optional<Boolean> delete(ID id);
}
