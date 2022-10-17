package br.edu.utfpr.e_markety.config.security.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

@Setter
@Getter
public class UsuarioDto {

    private Long id;

    @NotEmpty @NotNull
    private String nome;

    @NotEmpty @NotNull
    private String email;

    @NotEmpty @NotNull
    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    private String senha;

    private String imagemUrl;
}
