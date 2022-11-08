package br.edu.utfpr.e_markety.exceptions;

public class OnlyExistsOneEnderecoException extends RuntimeException {
    public OnlyExistsOneEnderecoException() {
        super("Não é possível excluir o endereço, pois ele é o único cadastrado.");
    }
}
