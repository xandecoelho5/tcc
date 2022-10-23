package br.edu.utfpr.e_markety.repository;

import br.edu.utfpr.e_markety.model.Produto;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.math.BigDecimal;
import java.util.List;

public interface ProdutoRepository extends GenericRepository<Produto, Long> {

    List<Produto> findAllByCategoriaId(Long id);

    List<Produto> findAllByIdIn(List<Long> ids);

    @Query(value = "SELECT p" +
            "  FROM Produto p" +
            " WHERE ((UPPER(p.nome) LIKE ?1) OR (?1 is null))" +
            "   AND ((p.categoria.id = ?2) OR (?2 is null))" +
            "   AND (p.preco BETWEEN ?3 AND ?4)")
    List<Produto> findAllByFilter(String nome, Long categoriaId, BigDecimal precoMin, BigDecimal precoMax, Sort sort);
}
