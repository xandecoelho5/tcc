package br.edu.utfpr.e_markety.exceptions;

public class NoneEstoqueForProdutoException extends RuntimeException {
    public NoneEstoqueForProdutoException(String nome) {
        super("Estoque insuficiente para o produto:\n" + nome);
    }
}
