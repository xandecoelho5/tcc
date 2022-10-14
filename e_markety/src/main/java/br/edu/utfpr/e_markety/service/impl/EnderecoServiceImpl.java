package br.edu.utfpr.e_markety.service.impl;

import br.edu.utfpr.e_markety.model.Endereco;
import br.edu.utfpr.e_markety.repository.EnderecoRepository;
import br.edu.utfpr.e_markety.repository.GenericRepository;
import br.edu.utfpr.e_markety.service.EnderecoService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class EnderecoServiceImpl extends GenericServiceImpl<Endereco, Long, Endereco> implements EnderecoService {

    private final EnderecoRepository repository;

    @Override
    protected GenericRepository<Endereco, Long> getRepository() {
        return repository;
    }
}
