package br.edu.utfpr.e_markety.service.impl;

import br.edu.utfpr.e_markety.exceptions.BairroNotFoundForEmpresaException;
import br.edu.utfpr.e_markety.model.Bairro;
import br.edu.utfpr.e_markety.model.Empresa;
import br.edu.utfpr.e_markety.model.EmpresaBairro;
import br.edu.utfpr.e_markety.repository.EmpresaBairroRepository;
import br.edu.utfpr.e_markety.repository.EmpresaRepository;
import br.edu.utfpr.e_markety.repository.GenericRepository;
import br.edu.utfpr.e_markety.service.EmpresaService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;

import static br.edu.utfpr.e_markety.utils.PrincipalUtils.getLoggedEmpresa;

@Service
@RequiredArgsConstructor
public class EmpresaServiceImpl extends GenericServiceImpl<Empresa, Long, Empresa> implements EmpresaService {

    private final EmpresaRepository repository;
    private final EmpresaBairroRepository empresaBairroRepository;

    @Override
    protected GenericRepository<Empresa, Long> getRepository() {
        return repository;
    }

    @Override
    public BigDecimal findTaxaEntregaByBairroId(Long bairroId) {
        var empresaBairro = empresaBairroRepository.findByEmpresaIdAndBairroId(getLoggedEmpresa().getId(), bairroId);
        if (empresaBairro == null) {
            throw new BairroNotFoundForEmpresaException();
        }
        return empresaBairro.getTaxaEntrega();
    }

    @Override
    public List<Bairro> findAllBairros() {
        var empresaBairros = empresaBairroRepository.findAllByEmpresaId(getLoggedEmpresa().getId());
        return empresaBairros.stream().map(EmpresaBairro::getBairro).toList();
    }
}
