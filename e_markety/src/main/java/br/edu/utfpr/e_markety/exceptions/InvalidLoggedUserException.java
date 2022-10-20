package br.edu.utfpr.e_markety.exceptions;

public class InvalidLoggedUserException extends RuntimeException {

    public InvalidLoggedUserException() {
        super("Usuário inválido ou não autorizado");
    }
}
