package br.edu.utfpr.e_markety.service.impl;

import br.edu.utfpr.e_markety.model.Empresa;
import br.edu.utfpr.e_markety.repository.EmpresaBairroRepository;
import br.edu.utfpr.e_markety.repository.EmpresaRepository;
import br.edu.utfpr.e_markety.repository.GenericRepository;
import br.edu.utfpr.e_markety.service.EmpresaService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class EmpresaServiceImpl extends GenericServiceImpl<Empresa, Long, Empresa> implements EmpresaService {

    private final EmpresaRepository repository;
    private final EmpresaBairroRepository empresaBairroRepository;

    @Override
    protected GenericRepository<Empresa, Long> getRepository() {
        return repository;
    }
}
