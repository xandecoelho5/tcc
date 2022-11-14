package br.edu.utfpr.e_markety.service.impl;

import br.edu.utfpr.e_markety.dto.PedidoItemDto;
import br.edu.utfpr.e_markety.dto.PrecoDto;
import br.edu.utfpr.e_markety.dto.ProdutoDto;
import br.edu.utfpr.e_markety.exceptions.ExistsLinkedDataException;
import br.edu.utfpr.e_markety.exceptions.NoneEstoqueForProdutoException;
import br.edu.utfpr.e_markety.model.Produto;
import br.edu.utfpr.e_markety.repository.GenericRepository;
import br.edu.utfpr.e_markety.repository.PedidoItemRepository;
import br.edu.utfpr.e_markety.repository.ProdutoRepository;
import br.edu.utfpr.e_markety.service.ProdutoService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;

import static br.edu.utfpr.e_markety.utils.PrincipalUtils.getLoggedEmpresa;

@Service
@RequiredArgsConstructor
public class ProdutoServiceImpl extends GenericServiceImpl<Produto, Long, ProdutoDto> implements ProdutoService {

    private final ProdutoRepository repository;
    private final PedidoItemRepository pedidoItemRepository;

    @Override
    protected GenericRepository<Produto, Long> getRepository() {
        return repository;
    }

    @Override
    protected void preSave(Produto entity, Long id) {
        super.preSave(entity, id);
        if (entity.getEmpresa() == null) {
            entity.setEmpresa(getLoggedEmpresa());
        }
    }

    @Override
    public List<ProdutoDto> findAllByCategoriaId(Long id) {
        var list = repository.findAllByCategoriaIdAndEmpresaId(id, getLoggedEmpresa().getId());
        return mapEntityListToDto(list);
    }

    @Override
    public List<ProdutoDto> findAllByIdIn(List<Long> ids) {
        var list = repository.findAllByIdInAndEmpresaId(ids, getLoggedEmpresa().getId());
        return mapEntityListToDto(list);
    }

    @Override
    public List<ProdutoDto> findAllByFilter(String nome, Long categoriaId, BigDecimal precoMin, BigDecimal precoMax, Sort sort) {
        var list = repository.findAllByFilter(getNome(nome), categoriaId, getPrecoMin(precoMin), getPrecoMax(precoMax), getLoggedEmpresa().getId(), sort);
        return mapEntityListToDto(list);
    }

    @Override
    public void validateProdutosEstoque(List<PedidoItemDto> dtos) {
        StringBuilder error = new StringBuilder();
        for (PedidoItemDto dto : dtos) {
            var estoque = repository.findEstoqueById(dto.getProdutoId());
            if (estoque < dto.getQuantidade()) {
                error.append(dto.getProdutoNome()).append(". Estoque atual: ").append(estoque).append(".");
            }
        }
        if (!error.isEmpty()) {
            throw new NoneEstoqueForProdutoException(error.toString());
        }
    }

    @Override
    public PrecoDto findMinAndMaxPreco() {
        return repository.findMinAndMaxPrecoByEmpresaId(getLoggedEmpresa().getId());
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
        Page<Produto> page = repository.findAllByEmpresaId(getLoggedEmpresa().getId(), pageable);
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
