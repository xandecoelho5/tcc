package br.edu.utfpr.e_markety.exceptions;

public class NoneOpenOrderException extends RuntimeException {
    public NoneOpenOrderException() {
        super("Não existe um pedido em aberto para este usuário");
    }
}
