package br.edu.utfpr.e_markety.model;

import lombok.*;

import javax.persistence.*;
import java.math.BigDecimal;

@Entity
@Getter
@Setter
@ToString
@NoArgsConstructor
public class EmpresaBairro {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "empresa_id", referencedColumnName = "id")
    private Empresa empresa;

    @ManyToOne
    @JoinColumn(name = "bairro_id", referencedColumnName = "id")
    private Bairro bairro;

    private BigDecimal taxaEntrega;
}
