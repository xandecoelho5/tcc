package br.edu.utfpr.e_markety.dto.relatorios;

import br.edu.utfpr.e_markety.model.enums.StatusPedido;
import lombok.AllArgsConstructor;
import lombok.Getter;

import javax.persistence.Tuple;
import java.math.BigDecimal;

@Getter
@AllArgsConstructor
public class ResumoStatus {

    private StatusPedido status;
    private BigDecimal percentual;

    public static ResumoStatus fromTuple(Tuple tuple) {
        return new ResumoStatus(
                StatusPedido.valueOf((String) tuple.get(0)),
                (BigDecimal) tuple.get(1)
        );
    }
}
