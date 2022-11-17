package br.edu.utfpr.e_markety.controller;

import br.edu.utfpr.e_markety.service.PedidoService;
import br.edu.utfpr.e_markety.service.ProdutoService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("relatorio")
public class RelatorioController {

    private final PedidoService pedidoService;
    private final ProdutoService produtoService;

    @GetMapping("/status")
    public ResponseEntity<?> relatorioStatusPedido() {
        return ResponseEntity.ok(pedidoService.relatorioStatusPedido());
    }

    @GetMapping("/produtos")
    public ResponseEntity<?> relatorioStatusPedido(@RequestParam String sort) {
        return ResponseEntity.ok(produtoService.relatorioVendaProdutos(sort));
    }

    @GetMapping("/pedidos-ano")
    public ResponseEntity<?> relatorioPedidosAno() {
        return ResponseEntity.ok(pedidoService.findPedidosByDataCriacaoBetween());
    }
}
