package br.edu.utfpr.e_markety.service.impl;

import br.edu.utfpr.e_markety.model.Categoria;
import br.edu.utfpr.e_markety.repository.CategoriaRepository;
import br.edu.utfpr.e_markety.repository.GenericRepository;
import br.edu.utfpr.e_markety.service.CategoriaService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class CategoriaServiceImpl extends GenericServiceImpl<Categoria, Long, Categoria> implements CategoriaService {

    private final CategoriaRepository repository;

    @Override
    protected GenericRepository<Categoria, Long> getRepository() {
        return repository;
    }
}
