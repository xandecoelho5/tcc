package br.edu.utfpr.e_markety.config.security.dto;

import lombok.Getter;
import lombok.Setter;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

@Getter
@Setter
public class LoginDto {

    @NotBlank(message = "O campo login é obrigatório")
    private String login;

    @NotBlank(message = "O campo senha é obrigatório")
    private String senha;

    @NotNull(message = "O campo empresa é obrigatório")
    private Long empresaId;

    public UsernamePasswordAuthenticationToken convert() {
        return new UsernamePasswordAuthenticationToken(login, senha);
    }
}
