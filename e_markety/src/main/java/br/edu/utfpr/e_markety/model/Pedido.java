package br.edu.utfpr.e_markety.model;

import br.edu.utfpr.e_markety.model.enums.StatusPedido;
import br.edu.utfpr.e_markety.model.enums.TipoEntrega;
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
public class Pedido {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private LocalDate data;

    private BigDecimal total;

    @Enumerated(EnumType.STRING)
    @Column(columnDefinition = "tipo_entrega_enum")
    @ColumnDefault("'RETIRADA'")
    private TipoEntrega tipoEntrega;

    @Column(length = 20)
    private String horarioEntrega;

    @Enumerated(EnumType.STRING)
    @Column(columnDefinition = "status_pedido_enum")
    @ColumnDefault("'REALIZADO'")
    private StatusPedido status;

    private String observacao;

    private BigDecimal taxaEntrega;

    @ManyToOne
    @JoinColumn(name = "usuario_id", referencedColumnName = "id", nullable = false)
    private Usuario usuario;

    @ManyToOne
    @JoinColumn(name = "endereco_id", referencedColumnName = "id")
    private Endereco endereco;
}
