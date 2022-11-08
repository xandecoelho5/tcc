package br.edu.utfpr.e_markety.model;

import br.edu.utfpr.e_markety.model.enums.StatusPedido;
import br.edu.utfpr.e_markety.model.enums.TipoEntrega;
import com.vladmihalcea.hibernate.type.basic.PostgreSQLEnumType;
import lombok.*;
import org.hibernate.annotations.Type;
import org.hibernate.annotations.TypeDef;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@Setter
@NoArgsConstructor
@TypeDef(name = "pgsql_enum", typeClass = PostgreSQLEnumType.class)
@EntityListeners(AuditingEntityListener.class)
public class Pedido {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "data_criacao", nullable = false, updatable = false)
    @CreatedDate
    private LocalDate dataCriacao;

    @Column(name = "data_atualizacao")
    @LastModifiedDate
    private LocalDate dataAtualizacao;

    @Column(columnDefinition = "decimal(10,2) default 0.00")
    private BigDecimal total;

    @Enumerated(EnumType.STRING)
    @Column(columnDefinition = "tipo_entrega_enum DEFAULT 'RETIRADA'::tipo_entrega_enum")
    @Type(type = "pgsql_enum")
    private TipoEntrega tipoEntrega;

    @Column
    private LocalDateTime horarioEntrega;

    @Enumerated(EnumType.STRING)
    @Column(columnDefinition = "status_pedido_enum DEFAULT 'PENDENTE'::status_pedido_enum")
    @Type(type = "pgsql_enum")
    private StatusPedido status;

    @Column
    private String observacao;

    @Column(columnDefinition = "decimal(5,2)")
    private BigDecimal taxaEntrega;

    @ManyToOne
    @JoinColumn(name = "usuario_id", referencedColumnName = "id", nullable = false)
    private Usuario usuario;

    @ManyToOne
    @JoinColumn(name = "endereco_id", referencedColumnName = "id")
    private Endereco endereco;

    @ManyToOne
    @JoinColumn(name = "empresa_id", referencedColumnName = "id")
    private Empresa empresa;

    @OneToMany(mappedBy = "pedido", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<PedidoItem> items = new ArrayList<>();
}
