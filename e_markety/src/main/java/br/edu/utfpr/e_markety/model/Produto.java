package br.edu.utfpr.e_markety.model;

import lombok.*;
import org.hibernate.annotations.ColumnDefault;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDate;

@Entity
@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Produto {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(length = 100, nullable = false)
    private String nome;

    @Column(length = 2048, nullable = false)
    private String imagemUrl;

    @Column(length = 512)
    private String descricao;

    @Column(nullable = false)
    private BigDecimal preco;

    @Column(nullable = false)
    private LocalDate data;

    @Column(nullable = false)
    private int estoque;

    @Column(nullable = false)
    @ColumnDefault("0")
    private int percentualDesconto;

    @Column
    @ColumnDefault("false")
    private boolean favorito;

    @Column(nullable = false)
    private float pesoPreco; // preço do KG/L
    // Ex: 1kg de arroz custa 5 reais, então pesoPreco = 1, 0.5kg de arroz custa 2.5 reais, então pesoUnidade = 0.5

    @Column(nullable = false)
    private float pesoUnidade; // peso da unidade, ex: 150g de 1kg

    @Column(nullable = false)
    private int quantidadeVendida;

    @ManyToOne
    @JoinColumn(name = "unidade_medida_id", referencedColumnName = "id", nullable = false)
    private UnidadeMedida unidadeMedida;

    @ManyToOne
    @JoinColumn(name = "categoria_id", referencedColumnName = "id", nullable = false)
    private Categoria categoria;

    @ManyToOne
    @JoinColumn(name = "empresa_id", referencedColumnName = "id", nullable = false)
    private Empresa empresa;
}
