package br.edu.utfpr.e_markety.exceptions;

public class UserAlreadyRegisteredException extends RuntimeException {
    public UserAlreadyRegisteredException() {
        super("Esse email já está cadastrado");
    }
}
