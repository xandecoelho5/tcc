package br.edu.utfpr.e_markety.service.impl;

import br.edu.utfpr.e_markety.exceptions.NoneDefaultAddressFoundException;
import br.edu.utfpr.e_markety.model.Endereco;
import br.edu.utfpr.e_markety.repository.EnderecoRepository;
import br.edu.utfpr.e_markety.repository.GenericUserRepository;
import br.edu.utfpr.e_markety.service.EnderecoService;
import br.edu.utfpr.e_markety.utils.PrincipalUtils;
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
    public Endereco getDefaultEndereco(Long id) {
        var endereco = repository.findEnderecoByUsuarioIdAndPadraoIsTrue(id);
        if (endereco == null) {
            throw new NoneDefaultAddressFoundException();
        }
        return endereco;
    }

    @Override
    protected void preSave(Endereco entity, Long id) {
//        if (entity.getPadrao()) {
//            repository.updateAllEnderecosToNotDefault(entity.getUsuario().getId());
//        }
        if (entity.getUsuario() == null) {
            entity.setUsuario(PrincipalUtils.getLoggedUsuario());
        }
    }
}
