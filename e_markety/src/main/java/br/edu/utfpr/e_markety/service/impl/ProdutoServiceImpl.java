package br.edu.utfpr.e_markety.service.impl;

import br.edu.utfpr.e_markety.dto.ProdutoDto;
import br.edu.utfpr.e_markety.model.Produto;
import br.edu.utfpr.e_markety.repository.EmpresaRepository;
import br.edu.utfpr.e_markety.repository.GenericRepository;
import br.edu.utfpr.e_markety.repository.ProdutoRepository;
import br.edu.utfpr.e_markety.service.ProdutoService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ProdutoServiceImpl extends GenericServiceImpl<Produto, Long, ProdutoDto> implements ProdutoService {

    private final ProdutoRepository repository;
    private final EmpresaRepository empresaRepository;

    @Override
    protected GenericRepository<Produto, Long> getRepository() {
        return repository;
    }

    @Override
    protected void preSave(Produto entity, Long aLong) {
        super.preSave(entity, aLong);
        if (entity.getEmpresa() == null) {
            entity.setEmpresa(empresaRepository.findById(1L).get());
        }
        if (entity.getData() == null) {
            entity.setData(LocalDate.now());
        }
    }

    @Override
    public List<ProdutoDto> findAllByCategoriaId(Long id) {
        var list = repository.findAllByCategoriaId(id);
        return mapEntityListToDto(list);
    }

    @Override
    public List<ProdutoDto> findAllByIdIn(List<Long> ids) {
        var list = repository.findAllByIdIn(ids);
        return mapEntityListToDto(list);
    }

    @Override
    public List<ProdutoDto> findAllByFilter(String nome, Long categoriaId, BigDecimal precoMin, BigDecimal precoMax, Sort sort) {
        var list = repository.findAllByFilter(getNome(nome), categoriaId, getPrecoMin(precoMin), getPrecoMax(precoMax), sort);
        return mapEntityListToDto(list);
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
