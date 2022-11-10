package br.edu.utfpr.e_markety.exceptions;

public class CurrentPasswordException extends RuntimeException {

    public CurrentPasswordException() {
        super("Senha atual incorreta");
    }
}
