package br.edu.utfpr.e_markety.model;

import lombok.*;

import javax.persistence.*;

@Entity
@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class UnidadeMedida {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(length = 3, nullable = false)
    private String abreviatura;

    @Column(nullable = false)
    private String descricao;
}
