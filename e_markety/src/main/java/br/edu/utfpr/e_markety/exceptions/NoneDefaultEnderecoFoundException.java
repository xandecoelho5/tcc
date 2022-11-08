package br.edu.utfpr.e_markety.exceptions;

public class NoneDefaultEnderecoFoundException extends RuntimeException {
    public NoneDefaultEnderecoFoundException() {
        super("Não existe endereço padrão cadastrado");
    }
}
