package br.edu.utfpr.e_markety.exceptions;

public class AlreadyExistsPendingPedidoException extends RuntimeException {
    public AlreadyExistsPendingPedidoException() {
        super("Já existe um pedido pendente para este usuário");
    }
}
