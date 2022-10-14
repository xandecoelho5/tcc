package br.edu.utfpr.e_markety.service.impl;

import br.edu.utfpr.e_markety.model.UnidadeMedida;
import br.edu.utfpr.e_markety.repository.GenericRepository;
import br.edu.utfpr.e_markety.repository.UnidadeMedidaRepository;
import br.edu.utfpr.e_markety.service.UnidadeMedidaService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class UnidadeMedidaServiceImpl extends GenericServiceImpl<UnidadeMedida, Long, UnidadeMedida> implements UnidadeMedidaService {

    private final UnidadeMedidaRepository repository;

    @Override
    protected GenericRepository<UnidadeMedida, Long> getRepository() {
        return repository;
    }
}
