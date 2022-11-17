package br.edu.utfpr.e_markety.service.impl;

import br.edu.utfpr.e_markety.dto.EmpresaBairroDto;
import br.edu.utfpr.e_markety.exceptions.BairroEmpresaAlreadyRegisteredException;
import br.edu.utfpr.e_markety.exceptions.BairroNotFoundForEmpresaException;
import br.edu.utfpr.e_markety.exceptions.NotFoundException;
import br.edu.utfpr.e_markety.model.EmpresaBairro;
import br.edu.utfpr.e_markety.repository.EmpresaBairroRepository;
import br.edu.utfpr.e_markety.repository.GenericRepository;
import br.edu.utfpr.e_markety.service.EmpresaBairroService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;

import static br.edu.utfpr.e_markety.utils.PrincipalUtils.getLoggedEmpresa;

@Service
@RequiredArgsConstructor
public class EmpresaBairroServiceImpl extends GenericServiceImpl<EmpresaBairro, Long, EmpresaBairroDto> implements EmpresaBairroService {

    private final EmpresaBairroRepository repository;

    @Override
    protected GenericRepository<EmpresaBairro, Long> getRepository() {
        return repository;
    }

    @Override
    public Page<EmpresaBairroDto> getAll(Pageable pageable) {
        var page = repository.findAllByEmpresaId(getLoggedEmpresa().getId(), pageable);
        return page.map(this::mapEntityToDto);
    }

    @Override
    public List<EmpresaBairroDto> getAll() {
        var list = repository.findAllByEmpresaId(getLoggedEmpresa().getId());
        return mapEntityListToDto(list);
    }

    @Override
    public BigDecimal findTaxaEntregaByBairroId(Long bairroId) {
        return findEmpresaBairroByBairroId(bairroId).getTaxaEntrega();
    }

    @Override
    public EmpresaBairro findEmpresaBairroByBairroId(Long bairroId) {
        var optionalEmpresaBairro = repository.findByEmpresaIdAndBairroId(getLoggedEmpresa().getId(), bairroId);
        return optionalEmpresaBairro.orElseThrow(BairroNotFoundForEmpresaException::new);
    }

    @Override
    protected void preSave(EmpresaBairro entity, Long id) {
        if (entity.getEmpresa() == null) {
            var empresa = getLoggedEmpresa();
            var empresaBairro = repository.findByEmpresaIdAndBairroId(empresa.getId(), entity.getBairro().getId());
            if (empresaBairro.isPresent()) {
                throw new BairroEmpresaAlreadyRegisteredException();
            }
            entity.setEmpresa(empresa);
        }
    }

    @Override
    protected EmpresaBairro findById(Long id) {
        var byId = repository.findByIdAndEmpresaId(id, getLoggedEmpresa().getId());
        return byId.orElseThrow(() -> new NotFoundException(id));
    }

    @Override
    protected void preUpdate(EmpresaBairroDto dto) {
        if (dto.getEmpresa() != null) {
            dto.setEmpresa(getLoggedEmpresa());
        }
    }
}
