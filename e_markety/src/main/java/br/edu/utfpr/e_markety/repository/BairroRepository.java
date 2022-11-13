package br.edu.utfpr.e_markety.repository;

import br.edu.utfpr.e_markety.model.Bairro;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface BairroRepository extends GenericRepository<Bairro, Long> {

    @Query("SELECT b FROM Bairro b WHERE b.id NOT IN (SELECT DISTINCT e.bairro.id FROM EmpresaBairro e WHERE e.empresa.id = ?1)")
    List<Bairro> findBairrosNotInEmpresa(Long empresaId);
}
