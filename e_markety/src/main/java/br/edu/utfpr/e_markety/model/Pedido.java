package br.edu.utfpr.e_markety.model;

import br.edu.utfpr.e_markety.model.enums.StatusPedido;
import br.edu.utfpr.e_markety.model.enums.TipoEntrega;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.*;
import org.hibernate.annotations.ColumnDefault;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

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

    @ColumnDefault("CURRENT_DATE")
    private LocalDate data;

    @Column(columnDefinition = "decimal(10,2) default 0.00")
    private BigDecimal total;

    @Enumerated(EnumType.STRING)
    @Column(columnDefinition = "tipo_entrega_enum")
    @ColumnDefault("'RETIRADA'")
    private TipoEntrega tipoEntrega;

    @Column
    private LocalDateTime horarioEntrega;

    @Enumerated(EnumType.STRING)
    @Column(columnDefinition = "status_pedido_enum")
    @ColumnDefault("'REALIZADO'")
    private StatusPedido status;

    private String observacao;

    private BigDecimal taxaEntrega;

    @ManyToOne
    @JoinColumn(name = "usuario_id", referencedColumnName = "id", nullable = false)
    @JsonIgnore
    private Usuario usuario;

    @ManyToOne
    @JoinColumn(name = "endereco_id", referencedColumnName = "id")
    private Endereco endereco;

    @OneToMany(mappedBy = "pedido", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<PedidoItem> items = new ArrayList<>();
}
