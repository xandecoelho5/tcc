package br.edu.utfpr.e_markety.model.enums;

import lombok.Getter;
import org.springframework.data.domain.Sort;

@Getter
public enum TipoOrdenacao {
    POPULARIDADE(Sort.by(Sort.Direction.DESC, "quantidadeVendida")),
    MAIS_BARATO(Sort.by(Sort.Direction.ASC, "preco")),
    MAIS_CARO(Sort.by(Sort.Direction.DESC, "preco")),
    DESCONTO(Sort.by(Sort.Direction.DESC, "percentualDesconto"));

    final Sort sort;

    TipoOrdenacao(Sort sort) {
        this.sort = sort;
    }
}
