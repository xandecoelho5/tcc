package br.edu.utfpr.e_markety.service.impl;

import br.edu.utfpr.e_markety.dto.ProdutoDto;
import br.edu.utfpr.e_markety.exceptions.ExistsLinkedDataException;
import br.edu.utfpr.e_markety.model.Produto;
import br.edu.utfpr.e_markety.repository.EmpresaRepository;
import br.edu.utfpr.e_markety.repository.GenericRepository;
import br.edu.utfpr.e_markety.repository.PedidoItemRepository;
import br.edu.utfpr.e_markety.repository.ProdutoRepository;
import br.edu.utfpr.e_markety.service.ProdutoService;
import br.edu.utfpr.e_markety.utils.PrincipalUtils;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
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
    private final PedidoItemRepository pedidoItemRepository;

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
    }

    @Override
    public List<ProdutoDto> findAllByCategoriaId(Long id) {
        var list = repository.findAllByCategoriaIdAndEmpresaId(id, PrincipalUtils.getLoggedEmpresa().getId());
        return mapEntityListToDto(list);
    }

    @Override
    public List<ProdutoDto> findAllByIdIn(List<Long> ids) {
        var list = repository.findAllByIdInAndEmpresaId(ids, PrincipalUtils.getLoggedEmpresa().getId());
        return mapEntityListToDto(list);
    }

    @Override
    public List<ProdutoDto> findAllByFilter(String nome, Long categoriaId, BigDecimal precoMin, BigDecimal precoMax, Sort sort) {
        var list = repository.findAllByFilter(getNome(nome), categoriaId, getPrecoMin(precoMin), getPrecoMax(precoMax), PrincipalUtils.getLoggedEmpresa().getId(), sort);
        return mapEntityListToDto(list);
    }

    @Override
    protected void preDelete(Long id) {
        super.preDelete(id);
        if (pedidoItemRepository.existsByProdutoId(id)) {
            throw new ExistsLinkedDataException("Não é possível excluir um produto que já foi comprado.");
        }
    }

    @Override
    public Page<ProdutoDto> getAll(Pageable pageable) {
        Page<Produto> page = repository.findAllByEmpresaId(PrincipalUtils.getLoggedEmpresa().getId(), pageable);
        return page.map(this::mapEntityToDto);
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
