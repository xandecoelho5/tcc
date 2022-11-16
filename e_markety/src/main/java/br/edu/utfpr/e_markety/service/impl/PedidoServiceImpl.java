package br.edu.utfpr.e_markety.service.impl;

import br.edu.utfpr.e_markety.dto.PedidoDto;
import br.edu.utfpr.e_markety.dto.relatorios.PedidosMes;
import br.edu.utfpr.e_markety.dto.relatorios.ResumoStatus;
import br.edu.utfpr.e_markety.exceptions.AlreadyExistsPendingPedidoException;
import br.edu.utfpr.e_markety.exceptions.NoneEstoqueForProdutoException;
import br.edu.utfpr.e_markety.exceptions.NoneOpenPedidoException;
import br.edu.utfpr.e_markety.model.Pedido;
import br.edu.utfpr.e_markety.model.enums.StatusPedido;
import br.edu.utfpr.e_markety.repository.GenericUserRepository;
import br.edu.utfpr.e_markety.repository.PedidoRepository;
import br.edu.utfpr.e_markety.repository.ProdutoRepository;
import br.edu.utfpr.e_markety.service.PedidoService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;

import static br.edu.utfpr.e_markety.utils.PrincipalUtils.getLoggedEmpresa;
import static br.edu.utfpr.e_markety.utils.PrincipalUtils.getLoggedUsuario;

@Service
@RequiredArgsConstructor
public class PedidoServiceImpl extends GenericServiceImpl<Pedido, Long, PedidoDto> implements PedidoService {

    private final PedidoRepository repository;
    private final ProdutoRepository produtoRepository;

    @Override
    protected GenericUserRepository<Pedido, Long> getRepository() {
        return repository;
    }

    @Override
    public PedidoDto createPedido() {
        var usuario = getLoggedUsuario();
        if (repository.existsByUsuarioIdAndStatusIs(usuario.getId(), StatusPedido.PENDENTE)) {
            throw new AlreadyExistsPendingPedidoException();
        }
        return save(new PedidoDto(usuario, getLoggedEmpresa()));
    }

    @Override
    public void updatePedidoStatus(Long id) {
        var pedido = findById(id);
        var newStatus = pedido.getStatus().getNext(pedido.getTipoEntrega());
        if (newStatus == StatusPedido.CONFIRMADO) {
            pedido.getItems().forEach(item -> updateEstoqueAndQuantidadeVendidaById(item.getProduto().getId(), item.getQuantidade()));
        }
        repository.updateStatus(id, newStatus);
    }

    @Override
    public List<ResumoStatus> relatorioStatusPedido() {
        var tuples = repository.relatorioStatusPedidoByEmpresaId(getLoggedEmpresa().getId());
        return tuples.stream()
                .map(ResumoStatus::fromTuple)
                .toList();
    }

    @Override
    public List<PedidosMes> findPedidosByDataCriacaoBetween() {
        var pedidos = repository.findPedidosByDataCriacaoBetweenByEmpresaId(getLoggedEmpresa().getId());
        List<PedidosMes> list = new ArrayList<>();
        var start = LocalDate.now().minus(11, ChronoUnit.MONTHS);
        for (int i = 0; i < 12; i++) {
            LocalDate finalDate = start.plus(i, ChronoUnit.MONTHS);
            var pedidosMes = pedidos.stream()
                    .filter(p -> p.getDataCriacao().getMonth() == finalDate.getMonth())
                    .toList();
            if (!pedidosMes.isEmpty()) {
                list.add(PedidosMes.of(finalDate, pedidosMes.size()));
            }
        }
        return list;
    }

    @Override
    public PedidoDto findOpenPedidoByUsuario() {
        var pedidos = repository.findAllByUsuarioIdAndStatusIsNot(getLoggedUsuario().getId(), StatusPedido.ENTREGUE);
        if (pedidos.isEmpty()) {
            throw new NoneOpenPedidoException();
        }

        return mapEntityToDto(pedidos.get(pedidos.size() - 1));
    }

    public Page<PedidoDto> findAllByEmpresa(Pageable pageable) {
        Page<Pedido> page = repository.findAllByEmpresaIdAndStatusIsNot(getLoggedEmpresa().getId(), StatusPedido.PENDENTE, pageable);
        return page.map(this::mapEntityToDto);
    }

    @Override
    public Page<PedidoDto> getAll(Pageable pageable) {
        Page<Pedido> page = repository.findAllByEmpresaIdAndUsuarioId(getLoggedEmpresa().getId(), getLoggedUsuario().getId(), pageable);
        return page.map(this::mapEntityToDto);
    }

    @Override
    protected Iterable<Pedido> findAllByUsuario(Pageable pageable) {
        var usuarioId = getLoggedUsuario().getId();
        return pageable == null ? repository.findAllByUsuarioIdAndStatusIsNot(usuarioId, StatusPedido.PENDENTE) :
                repository.findAllByUsuarioIdAndStatusIsNot(usuarioId, StatusPedido.PENDENTE, pageable);
    }

    @Override
    protected void preSave(Pedido entity, Long id) {
        super.preSave(entity, id);
        if (id != null && StatusPedido.PENDENTE == entity.getStatus()) {
            entity.setStatus(StatusPedido.REALIZADO);
        }
    }

    @Override
    protected void preUpdate(PedidoDto dto) {
        if (dto.getUsuario() == null) {
            dto.setUsuario(getLoggedUsuario());
            dto.setEmpresa(getLoggedEmpresa());
            for (var item : dto.getItems()) {
                item.setPedido(mapDtoToEntity(dto));
            }
        }
    }

    private void updateEstoqueAndQuantidadeVendidaById(Long id, float quantidade) {
        var produto = produtoRepository.findById(id).get();

        var estoque = produto.getEstoque() - quantidade;
        if (estoque < 0) {
            throw new NoneEstoqueForProdutoException(produto.getNome());
        }
        var quantidadeVendida = produto.getQuantidadeVendida() + quantidade;

        produto.setEstoque(estoque);
        produto.setQuantidadeVendida(quantidadeVendida);
        produtoRepository.save(produto);
    }
}
