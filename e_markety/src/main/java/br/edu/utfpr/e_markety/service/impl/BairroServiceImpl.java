package br.edu.utfpr.e_markety.service.impl;

import br.edu.utfpr.e_markety.model.Bairro;
import br.edu.utfpr.e_markety.repository.BairroRepository;
import br.edu.utfpr.e_markety.repository.GenericRepository;
import br.edu.utfpr.e_markety.service.BairroService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

import static br.edu.utfpr.e_markety.utils.PrincipalUtils.getLoggedEmpresa;

@Service
@RequiredArgsConstructor
public class BairroServiceImpl extends GenericServiceImpl<Bairro, Long, Bairro> implements BairroService {

    private final BairroRepository repository;

    @Override
    protected GenericRepository<Bairro, Long> getRepository() {
        return repository;
    }

    @Override
    public List<Bairro> getBairrosWithoutCurrentEmpresa() {
        return repository.findBairrosNotInEmpresa(getLoggedEmpresa().getId());
    }
}
