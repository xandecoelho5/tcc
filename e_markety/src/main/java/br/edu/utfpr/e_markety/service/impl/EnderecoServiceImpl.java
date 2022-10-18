package br.edu.utfpr.e_markety.service.impl;

import br.edu.utfpr.e_markety.model.Endereco;
import br.edu.utfpr.e_markety.repository.EnderecoRepository;
import br.edu.utfpr.e_markety.repository.GenericRepository;
import br.edu.utfpr.e_markety.service.EnderecoService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class EnderecoServiceImpl extends GenericServiceImpl<Endereco, Long, Endereco> implements EnderecoService {

    private final EnderecoRepository repository;

    @Override
    protected GenericRepository<Endereco, Long> getRepository() {
        return repository;
    }

    @Override
    public List<Endereco> findAllByUsuarioId(Long id) {
        return repository.findAllByUsuarioId(id);
    }

    @Override
    public Endereco getDefaultAddress(Long id) {
        return repository.findEnderecoByUsuarioIdAndPadraoIsTrue(id);
    }
}
