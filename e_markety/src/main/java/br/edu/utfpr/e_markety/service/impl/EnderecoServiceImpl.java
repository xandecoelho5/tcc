package br.edu.utfpr.e_markety.service.impl;

import br.edu.utfpr.e_markety.exceptions.ExistsLinkedDataException;
import br.edu.utfpr.e_markety.exceptions.NoneDefaultEnderecoFoundException;
import br.edu.utfpr.e_markety.exceptions.OnlyExistsOneEnderecoException;
import br.edu.utfpr.e_markety.model.Endereco;
import br.edu.utfpr.e_markety.repository.EmpresaRepository;
import br.edu.utfpr.e_markety.repository.EnderecoRepository;
import br.edu.utfpr.e_markety.repository.GenericUserRepository;
import br.edu.utfpr.e_markety.repository.PedidoRepository;
import br.edu.utfpr.e_markety.service.EnderecoService;
import br.edu.utfpr.e_markety.utils.PrincipalUtils;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class EnderecoServiceImpl extends GenericServiceImpl<Endereco, Long, Endereco> implements EnderecoService {

    private final EnderecoRepository repository;
    private final EmpresaRepository empresaRepository;
    private final PedidoRepository pedidoRepository;

    @Override
    protected GenericUserRepository<Endereco, Long> getRepository() {
        return repository;
    }

    @Override
    public Endereco getDefaultEndereco(Long id) {
        var endereco = repository.findEnderecoByUsuarioIdAndPadraoIsTrue(id);
        if (endereco == null) {
            throw new NoneDefaultEnderecoFoundException();
        }
        return endereco;
    }

    @Override
    protected void preSave(Endereco entity, Long id) {
        if (entity.getUsuario() == null) {
            entity.setUsuario(PrincipalUtils.getLoggedUsuario());
        }
        if (entity.isPadrao()) {
            repository.updateAllEnderecosToNotDefault(entity.getUsuario().getId());
        }
        if (!entity.isPadrao() && repository.countAllByUsuarioId(entity.getUsuario().getId()) == 0) {
            entity.setPadrao(true);
        }
    }

    @Override
    protected void preDelete(Long id) {
        verifyAddressCount(id);
        verifyLinkedData(id);
        super.preDelete(id);
    }

    private void verifyAddressCount(Long id) {
        var count = repository.countAllByUsuarioId(id);
        if (count == 1) throw new OnlyExistsOneEnderecoException();
    }

    private void verifyLinkedData(Long id) {
        if (empresaRepository.existsByEnderecoId(id)) {
            throw new ExistsLinkedDataException("Não é possível excluir um endereço que está vinculado a uma empresa");
        }
        if (pedidoRepository.existsByEnderecoId(id)) {
            throw new ExistsLinkedDataException("Não é possível excluir um endereço que está vinculado a um pedido");
        }
    }
}
