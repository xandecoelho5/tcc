package br.edu.utfpr.e_markety.service.impl;

import br.edu.utfpr.e_markety.exceptions.AlreadyExistsPendingOrderException;
import br.edu.utfpr.e_markety.exceptions.NoneOpenOrderException;
import br.edu.utfpr.e_markety.model.Pedido;
import br.edu.utfpr.e_markety.model.enums.StatusPedido;
import br.edu.utfpr.e_markety.repository.GenericUserRepository;
import br.edu.utfpr.e_markety.repository.PedidoRepository;
import br.edu.utfpr.e_markety.service.PedidoService;
import br.edu.utfpr.e_markety.utils.PrincipalUtils;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class PedidoServiceImpl extends GenericServiceImpl<Pedido, Long, Pedido> implements PedidoService {

    private final PedidoRepository repository;

    @Override
    protected GenericUserRepository<Pedido, Long> getRepository() {
        return repository;
    }

    @Override
    public void existsPendingPedidoByUsuarioId(Long usuarioId) {
        if (repository.existsByUsuarioIdAndStatusIs(usuarioId, StatusPedido.PENDENTE)) {
            throw new AlreadyExistsPendingOrderException();
        }
    }

    @Override
    public Pedido findOpenPedidoByUsuarioId(Long usuarioId) {
//        var optionalPedido = repository.findByUsuarioIdAndStatusIs(usuarioId, StatusPedido.PENDENTE);
        var pedidos = repository.findAllByUsuarioIdAndStatusIsNot(usuarioId, StatusPedido.ENTREGUE);
        if (pedidos.isEmpty()) {
            throw new NoneOpenOrderException();
        }
        return pedidos.get(pedidos.size() - 1);
    }

    public Page<Pedido> findAllByEmpresa(Pageable pageable) {
        Page<Pedido> page = repository.findAllByEmpresaId(PrincipalUtils.getLoggedEmpresa().getId(), pageable);
        return page.map(this::mapEntityToDto);
    }

    @Override
    public Page<Pedido> getAll(Pageable pageable) {
        Page<Pedido> page = repository.findAllByEmpresaIdAndUsuarioId(PrincipalUtils.getLoggedEmpresa().getId(),
                PrincipalUtils.getLoggedUsuario().getId(), pageable);
        return page.map(this::mapEntityToDto);
    }

    @Override
    protected Iterable<Pedido> findAllByUsuario(Pageable pageable) {
        var usuarioId = PrincipalUtils.getLoggedUsuario().getId();
        return pageable == null ?
                repository.findAllByUsuarioIdAndStatusIsNot(usuarioId, StatusPedido.PENDENTE) :
                repository.findAllByUsuarioIdAndStatusIsNot(usuarioId, StatusPedido.PENDENTE, pageable);
    }
}
