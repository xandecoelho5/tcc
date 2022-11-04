package br.edu.utfpr.e_markety.model;

import br.edu.utfpr.e_markety.model.enums.Tag;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.vladmihalcea.hibernate.type.basic.PostgreSQLEnumType;
import lombok.*;
import org.hibernate.annotations.Type;
import org.hibernate.annotations.TypeDef;

import javax.persistence.*;

@Entity
@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@TypeDef(name = "pgsql_enum", typeClass = PostgreSQLEnumType.class)
public class Endereco {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Enumerated(EnumType.STRING)
    @Column(columnDefinition = "tag_enum DEFAULT 'OUTRO'::tag_enum")
    @Type(type = "pgsql_enum")
    private Tag tag = Tag.OUTRO;

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
    @JsonIgnore
    private Usuario usuario;
}
