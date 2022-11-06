package br.edu.utfpr.e_markety.config.security.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UsuarioEditDto {

    private String nome;
    private String email;
    private String imagemUrl;
}
