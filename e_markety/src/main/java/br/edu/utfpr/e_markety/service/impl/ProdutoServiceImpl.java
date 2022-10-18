package br.edu.utfpr.e_markety.service.impl;

import br.edu.utfpr.e_markety.model.Produto;
import br.edu.utfpr.e_markety.repository.GenericRepository;
import br.edu.utfpr.e_markety.repository.ProdutoRepository;
import br.edu.utfpr.e_markety.service.ProdutoService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ProdutoServiceImpl extends GenericServiceImpl<Produto, Long, Produto> implements ProdutoService {

    private final ProdutoRepository repository;

    @Override
    protected GenericRepository<Produto, Long> getRepository() {
        return repository;
    }

    @Override
    public List<Produto> findAllByCategoriaId(Long id) {
        return repository.findAllByCategoriaId(id);
    }
}
