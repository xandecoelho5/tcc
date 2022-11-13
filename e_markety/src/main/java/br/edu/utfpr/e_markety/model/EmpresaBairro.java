package br.edu.utfpr.e_markety.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.*;

import javax.persistence.*;
import java.math.BigDecimal;

@Entity
@Getter
@Setter
@NoArgsConstructor
public class EmpresaBairro {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "empresa_id", referencedColumnName = "id")
    @JsonIgnore
    private Empresa empresa;

    @ManyToOne
    @JoinColumn(name = "bairro_id", referencedColumnName = "id")
    private Bairro bairro;

    @Column(columnDefinition = "decimal(5,2)")
    private BigDecimal taxaEntrega;
}
