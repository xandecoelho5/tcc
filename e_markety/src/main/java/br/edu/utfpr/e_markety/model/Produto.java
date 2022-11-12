package br.edu.utfpr.e_markety.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.*;
import org.hibernate.annotations.ColumnDefault;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDate;

@Entity
@Getter
@Setter
@NoArgsConstructor
@EntityListeners(AuditingEntityListener.class)
public class Produto {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(length = 100, nullable = false)
    private String nome;

    @Column(length = 2048, nullable = false)
    private String imagemUrl;

    @Column(length = 1024)
    private String descricao;

    @Column(nullable = false)
    private BigDecimal preco;

    @Column(name = "data_criacao", nullable = false, updatable = false)
    @CreatedDate
    private LocalDate dataCriacao;

    @Column(name = "data_atualizacao")
    @LastModifiedDate
    private LocalDate dataAtualizacao;

    @Column(nullable = false)
    private float estoque;

    @Column(nullable = false)
    @ColumnDefault("0")
    private int percentualDesconto;

    @Column(nullable = false)
    private float pesoPreco; // preço do KG/L
    // Ex: 1kg de arroz custa 5 reais, então pesoPreco = 1, 0.5kg de arroz custa 2.5 reais, então pesoUnidade = 0.5

    @Column(nullable = false)
    private float pesoUnidade; // peso da unidade, ex: 150g de 1kg

    @Column(nullable = false)
    private float quantidadeVendida;

    @ManyToOne
    @JoinColumn(name = "unidade_medida_id", referencedColumnName = "id", nullable = false)
    private UnidadeMedida unidadeMedida;

    @ManyToOne
    @JoinColumn(name = "categoria_id", referencedColumnName = "id", nullable = false)
    private Categoria categoria;

    @ManyToOne
    @JoinColumn(name = "empresa_id", referencedColumnName = "id", nullable = false)
    @JsonIgnore
    private Empresa empresa;
}
