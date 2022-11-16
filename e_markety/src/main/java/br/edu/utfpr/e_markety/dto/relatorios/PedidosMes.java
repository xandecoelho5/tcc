package br.edu.utfpr.e_markety.dto.relatorios;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class PedidosMes {

    private int mes;
    private int ano;
    private int quantidade;
}
