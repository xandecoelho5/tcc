package br.edu.utfpr.e_markety.config.security.dto;

import lombok.Getter;
import lombok.Setter;

import javax.validation.constraints.NotBlank;

@Setter
@Getter
public class SenhaDto {

    @NotBlank
    private String senhaAtual;

    @NotBlank
    private String novaSenha;
}
