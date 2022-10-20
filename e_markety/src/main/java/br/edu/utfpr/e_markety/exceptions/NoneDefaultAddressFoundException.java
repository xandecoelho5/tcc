package br.edu.utfpr.e_markety.exceptions;

public class NoneDefaultAddressFoundException extends RuntimeException {
    public NoneDefaultAddressFoundException() {
        super("Não existe endereço padrão cadastrado");
    }
}
