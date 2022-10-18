package br.edu.utfpr.e_markety.model;

import br.edu.utfpr.e_markety.config.security.dto.UsuarioDto;
import br.edu.utfpr.e_markety.model.enums.Tag;
import lombok.*;
import org.hibernate.annotations.ColumnDefault;

import javax.persistence.*;

@Entity
@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Endereco {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Enumerated(EnumType.STRING)
    @Column(columnDefinition = "tag_enum")
    @ColumnDefault("'OUTRO'")
    private Tag tag;

    @Column(length = 60, nullable = false)
    private String nome;

    @Column(length = 17, nullable = false)
    private String telefone;

    @Column(length = 100, nullable = false)
    private String rua;

    @Column(length = 100)
    private String referencia;

    @Column(columnDefinition = "boolean default false")
    private boolean padrao;

    @ManyToOne
    @JoinColumn(name = "bairro_id", referencedColumnName = "id", nullable = false)
    private Bairro bairro;

    @ManyToOne
    @JoinColumn(name = "usuario_id", referencedColumnName = "id", nullable = false)
    private Usuario usuario;

    public UsuarioDto getUsuario() {
        return UsuarioDto.fromUsuario(usuario);
    }
}
