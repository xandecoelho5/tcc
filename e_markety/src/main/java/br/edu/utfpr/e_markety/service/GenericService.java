package br.edu.utfpr.e_markety.service;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface GenericService <ID, Y> {

    List<Y> getAll();

    Page<Y> getAll(Pageable pageable);

    Y save(Y dto);

    Y update(ID id, Y dto);

    Y getById(ID id);

    void delete(ID id);
}
