package br.edu.utfpr.e_markety.dto;

import br.edu.utfpr.e_markety.model.enums.TipoOrdenacao;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import java.math.BigDecimal;

@Getter
@Setter
@NoArgsConstructor
@ToString
public class FiltroDto {

    private String nome;
    private BigDecimal precoMin;
    private BigDecimal precoMax;
    private TipoOrdenacao tipoOrdenacao;
    private Long categoriaId;
}
