package br.edu.utfpr.e_markety.exceptions;

public class AlreadyExistsPendingOrderException extends RuntimeException {
    public AlreadyExistsPendingOrderException() {
        super("Já existe um pedido pendente para este usuário");
    }
}
