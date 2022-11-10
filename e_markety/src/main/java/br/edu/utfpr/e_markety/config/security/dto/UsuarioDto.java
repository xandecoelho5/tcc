package br.edu.utfpr.e_markety.config.security.dto;

import br.edu.utfpr.e_markety.model.Usuario;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import java.util.List;

@Setter
@Getter
@ToString
public class UsuarioDto {

    private Long id;

    @NotBlank
    private String nome;

    @NotBlank @Email
    private String email;

    private String telefone;

    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    private String senha;

    private String imagemUrl;

    private List<Long> favoritosIds;

    public static UsuarioDto fromUsuario(Usuario usuario) {
        UsuarioDto usuarioDto = new UsuarioDto();

        usuarioDto.setId(usuario.getId());
        usuarioDto.setNome(usuario.getNome());
        usuarioDto.setEmail(usuario.getEmail());
        usuarioDto.setTelefone(usuario.getTelefone());
        usuarioDto.setImagemUrl(usuario.getImagemUrl());
        usuarioDto.setFavoritosIds(usuario.getFavoritosIds());

        return usuarioDto;
    }
}
