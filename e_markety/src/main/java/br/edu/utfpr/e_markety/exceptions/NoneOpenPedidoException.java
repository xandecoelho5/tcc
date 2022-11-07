package br.edu.utfpr.e_markety.exceptions;

public class NoneOpenPedidoException extends RuntimeException {
    public NoneOpenPedidoException() {
        super("Não existe um pedido em aberto para este usuário");
    }
}
