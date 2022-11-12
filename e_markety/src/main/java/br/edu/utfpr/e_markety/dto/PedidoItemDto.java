package br.edu.utfpr.e_markety.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

@Getter
@Setter
@NoArgsConstructor
public class PedidoItemDto {

    @NotNull
    private Long produtoId;

    @NotBlank
    private String produtoNome;

    @NotNull
    private float quantidade;
}
