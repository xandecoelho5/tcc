package br.edu.utfpr.e_markety.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.*;

import javax.persistence.*;

@Entity
@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Empresa {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String nome;

    @Column(length = 17, nullable = false)
    private String telefone;

    @Column(length = 17)
    private String celular;

    @Column(length = 1024, nullable = false)
    private String logo;

    @Column(length = 20)
    private String deliveryAbertura;

    @Column(length = 20)
    private String deliveryFechamento;

    @Column(length = 20)
    private String lojaAbertura;

    @Column(length = 20)
    private String lojaFechamento;

    @ManyToOne
    @JoinColumn(name = "endereco_id", referencedColumnName = "id", nullable = false)
    private Endereco endereco;
}
