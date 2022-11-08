package br.edu.utfpr.e_markety.service;

import br.edu.utfpr.e_markety.model.Bairro;
import br.edu.utfpr.e_markety.model.Empresa;

import java.math.BigDecimal;
import java.util.List;

public interface EmpresaService extends GenericService<Long, Empresa> {

    BigDecimal findTaxaEntregaByBairroId(Long bairroId);

    List<Bairro> findAllBairros();
}
