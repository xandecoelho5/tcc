package br.edu.utfpr.e_markety.exceptions;

public class OnlyExistsOneAddressException extends RuntimeException {
    public OnlyExistsOneAddressException() {
        super("Não é possível excluir o endereço, pois ele é o único cadastrado.");
    }
}
