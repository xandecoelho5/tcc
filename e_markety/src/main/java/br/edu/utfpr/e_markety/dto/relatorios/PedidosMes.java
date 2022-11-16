package br.edu.utfpr.e_markety.dto.relatorios;

import lombok.AllArgsConstructor;
import lombok.Getter;

import java.time.LocalDate;

@Getter
@AllArgsConstructor
public class PedidosMes {

    private int mes;
    private int ano;
    private int quantidade;

    public static PedidosMes of(LocalDate data, int quantidade) {
        return new PedidosMes(data.getMonthValue(), data.getYear(), quantidade);
    }
}
