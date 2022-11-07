package br.edu.utfpr.e_markety.dto;

import br.edu.utfpr.e_markety.config.security.dto.UsuarioDto;
import br.edu.utfpr.e_markety.model.Endereco;
import br.edu.utfpr.e_markety.model.PedidoItem;
import br.edu.utfpr.e_markety.model.Usuario;
import br.edu.utfpr.e_markety.model.enums.StatusPedido;
import br.edu.utfpr.e_markety.model.enums.TipoEntrega;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@ToString
public class PedidoDto {

    private Long id;

    private LocalDate data = LocalDate.now();

    private BigDecimal total = BigDecimal.valueOf(0.00);

    private TipoEntrega tipoEntrega = TipoEntrega.RETIRADA;

    private LocalDateTime horarioEntrega;

    private StatusPedido status = StatusPedido.PENDENTE;

    private String observacao = "";

    private BigDecimal taxaEntrega;

    @JsonProperty(access = JsonProperty.Access.READ_ONLY)
    private Usuario usuario;

    private Endereco endereco;

    private List<PedidoItem> items = new ArrayList<>();

    public PedidoDto(Usuario usuario) {
        this.usuario = usuario;
    }

    public UsuarioDto getUsuario() {
        return UsuarioDto.fromUsuario(usuario);
    }
}
