package br.edu.utfpr.e_markety.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.NoRepositoryBean;

import java.util.List;

@NoRepositoryBean
public interface GenericUserRepository<T, ID> extends GenericRepository<T, ID> {

    List<T> findAllByUsuarioId(ID id);

    Page<T> findAllByUsuarioId(ID id, Pageable pageable);
}
