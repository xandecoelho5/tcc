package br.edu.utfpr.e_markety.dto.relatorios;

import lombok.AllArgsConstructor;
import lombok.Getter;

import javax.persistence.Tuple;

@Getter
@AllArgsConstructor
public class VendaProdutos {

    private String nome;
    private float quantidade;

    public static VendaProdutos fromTuple(Tuple tuple) {
        return new VendaProdutos(
                (String) tuple.get(0),
                (float) tuple.get(1)
        );
    }
}
