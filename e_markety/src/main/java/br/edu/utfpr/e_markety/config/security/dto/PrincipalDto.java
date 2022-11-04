package br.edu.utfpr.e_markety.config.security.dto;

import br.edu.utfpr.e_markety.model.Empresa;
import br.edu.utfpr.e_markety.model.Usuario;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.ToString;

@AllArgsConstructor
@Getter
@ToString
public class PrincipalDto {

    private Usuario usuario;
    private Empresa empresa;
}
