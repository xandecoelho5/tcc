package br.edu.utfpr.e_markety.model;

import lombok.*;

import javax.persistence.*;

@Entity
@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Categoria {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(length = 60, nullable = false)
    private String nome;

    @Column(length = 2048, nullable = false)
    private String imagemUrl;

    @Column(length = 2048, nullable = false)
    private String iconUrl;

    @Column(length = 20, nullable = false)
    private String cor;

}
