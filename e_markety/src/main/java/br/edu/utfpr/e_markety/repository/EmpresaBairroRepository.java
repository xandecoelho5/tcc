package br.edu.utfpr.e_markety.repository;

import br.edu.utfpr.e_markety.model.EmpresaBairro;

import java.util.List;

public interface EmpresaBairroRepository extends GenericRepository<EmpresaBairro, Long> {

    EmpresaBairro findByEmpresaIdAndBairroId(Long empresaId, Long bairroId);

    List<EmpresaBairro> findAllByEmpresaId(Long empresaId);
}
