package br.edu.utfpr.e_markety.service;

import br.edu.utfpr.e_markety.dto.EmpresaBairroDto;

import java.math.BigDecimal;

public interface EmpresaBairroService extends GenericService<Long, EmpresaBairroDto> {

    BigDecimal findTaxaEntregaByBairroId(Long bairroId);
}
