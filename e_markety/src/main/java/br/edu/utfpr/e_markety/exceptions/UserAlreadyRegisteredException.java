package br.edu.utfpr.e_markety.exceptions;

public class UserAlreadyRegisteredException extends RuntimeException {
    public UserAlreadyRegisteredException() {
        super("Usuário já cadastrado");
    }
}
