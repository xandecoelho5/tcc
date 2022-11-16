package br.edu.utfpr.e_markety.model;

import com.vladmihalcea.hibernate.type.array.ListArrayType;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.Type;
import org.hibernate.annotations.TypeDef;

import javax.persistence.*;
import java.math.BigDecimal;
import java.util.List;

@Entity
@Getter
@Setter
@NoArgsConstructor
@TypeDef(name = "list-array", typeClass = ListArrayType.class)
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

    @Column(precision = 5, scale = 2, nullable = false)
    private BigDecimal taxaServico;

    @ManyToOne(optional = false)
    @JoinColumn(name = "endereco_id", referencedColumnName = "id", nullable = false)
    private Endereco endereco;

    @Type(type = "list-array")
    @Column(name = "banners", columnDefinition = "text[]")
    private List<String> banners;
}
