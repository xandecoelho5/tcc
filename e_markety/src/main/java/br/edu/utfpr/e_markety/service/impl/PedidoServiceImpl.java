package br.edu.utfpr.e_markety.service.impl;

import br.edu.utfpr.e_markety.exceptions.AlreadyExistsPendingOrderException;
import br.edu.utfpr.e_markety.exceptions.NoneOpenOrderException;
import br.edu.utfpr.e_markety.model.Pedido;
import br.edu.utfpr.e_markety.model.enums.StatusPedido;
import br.edu.utfpr.e_markety.repository.GenericUserRepository;
import br.edu.utfpr.e_markety.repository.PedidoRepository;
import br.edu.utfpr.e_markety.service.PedidoService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

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

    @Override
    public List<Pedido> getAllByCurrentUser(Long usuarioId) {
        return repository.findAllByUsuarioIdAndStatusIsNot(usuarioId, StatusPedido.PENDENTE);
    }
}
