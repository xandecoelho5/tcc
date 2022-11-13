package br.edu.utfpr.e_markety.repository;

import br.edu.utfpr.e_markety.dto.PrecoDto;
import br.edu.utfpr.e_markety.model.Produto;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.Query;

import java.math.BigDecimal;
import java.util.List;

public interface ProdutoRepository extends GenericRepository<Produto, Long> {

    List<Produto> findAllByCategoriaIdAndEmpresaId(Long id, Long empresaId);

    List<Produto> findAllByIdInAndEmpresaId(List<Long> ids, Long empresaId);

    @Query(value = "SELECT p" +
            "  FROM Produto p" +
            " WHERE ((UPPER(p.nome) LIKE ?1) OR (?1 is null))" +
            "   AND ((p.categoria.id = ?2) OR (?2 is null))" +
            "   AND (p.preco BETWEEN ?3 AND ?4)" +
            "   AND (p.empresa.id = ?5)")
    List<Produto> findAllByFilter(String nome, Long categoriaId, BigDecimal precoMin, BigDecimal precoMax, Long empresaId, Sort sort);

    Page<Produto> findAllByEmpresaId(Long id, Pageable pageable);

    @Query(value = "SELECT p.estoque FROM Produto p WHERE p.id = :id")
    float findEstoqueById(Long id);

    @Query("SELECT new br.edu.utfpr.e_markety.dto.PrecoDto(MIN(p.preco), MAX(p.preco)) FROM Produto p WHERE p.empresa.id = :empresaId")
    PrecoDto findMinAndMaxPrecoByEmpresaId(Long empresaId);
}
