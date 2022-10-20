package br.edu.utfpr.e_markety.service.impl;

import br.edu.utfpr.e_markety.exceptions.NoneDefaultAddressFoundException;
import br.edu.utfpr.e_markety.model.Endereco;
import br.edu.utfpr.e_markety.repository.EnderecoRepository;
import br.edu.utfpr.e_markety.repository.GenericUserRepository;
import br.edu.utfpr.e_markety.service.EnderecoService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class EnderecoServiceImpl extends GenericServiceImpl<Endereco, Long, Endereco> implements EnderecoService {

    private final EnderecoRepository repository;

    @Override
    protected GenericUserRepository<Endereco, Long> getRepository() {
        return repository;
    }

    @Override
    public Endereco getDefaultAddress(Long id) {
        var address = repository.findEnderecoByUsuarioIdAndPadraoIsTrue(id);
        if (address == null) {
            throw new NoneDefaultAddressFoundException();
        }
        return address;
    }
}
