package br.edu.utfpr.e_markety.config.security.dto;

import br.edu.utfpr.e_markety.model.Usuario;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.util.List;

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

    private List<Long> favoritosIds;

    public static UsuarioDto fromUsuario(Usuario usuario) {
        UsuarioDto usuarioDto = new UsuarioDto();

        usuarioDto.setId(usuario.getId());
        usuarioDto.setNome(usuario.getNome());
        usuarioDto.setEmail(usuario.getEmail());
        usuarioDto.setImagemUrl(usuario.getImagemUrl());
        usuarioDto.setFavoritosIds(usuario.getFavoritosIds());

        return usuarioDto;
    }
}
