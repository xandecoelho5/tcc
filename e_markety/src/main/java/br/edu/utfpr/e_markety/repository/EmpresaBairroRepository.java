package br.edu.utfpr.e_markety.repository;

import br.edu.utfpr.e_markety.model.EmpresaBairro;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Optional;

public interface EmpresaBairroRepository extends GenericRepository<EmpresaBairro, Long> {

    Optional<EmpresaBairro> findByEmpresaIdAndBairroId(Long empresaId, Long bairroId);

    Optional<EmpresaBairro> findByIdAndEmpresaId(Long id, Long empresaId);

    List<EmpresaBairro> findAllByEmpresaId(Long empresaId);

    Page<EmpresaBairro> findAllByEmpresaId(Long empresaId, Pageable pageable);
}
