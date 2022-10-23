package br.edu.utfpr.e_markety.service.impl;

import br.edu.utfpr.e_markety.model.Produto;
import br.edu.utfpr.e_markety.repository.GenericRepository;
import br.edu.utfpr.e_markety.repository.ProdutoRepository;
import br.edu.utfpr.e_markety.service.ProdutoService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
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

    @Override
    public List<Produto> findAllByIdIn(List<Long> ids) {
        return repository.findAllByIdIn(ids);
    }

    @Override
    public List<Produto> findAllByFilter(String nome, Long categoriaId, BigDecimal precoMin, BigDecimal precoMax, Sort sort) {
        return repository.findAllByFilter(getNome(nome), categoriaId, getPrecoMin(precoMin), getPrecoMax(precoMax), sort);
    }

    private BigDecimal getPrecoMin(BigDecimal precoMin) {
        return precoMin == null ? BigDecimal.ZERO : precoMin;
    }

    private BigDecimal getPrecoMax(BigDecimal precoMax) {
        return precoMax == null ? BigDecimal.valueOf(99999) : precoMax;
    }

    private String getNome(String nome) {
        return nome == null ? null : "%" + nome.toUpperCase() + "%";
    }
}
