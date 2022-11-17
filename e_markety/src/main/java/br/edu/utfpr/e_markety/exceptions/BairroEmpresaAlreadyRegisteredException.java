package br.edu.utfpr.e_markety.exceptions;

public class BairroEmpresaAlreadyRegisteredException extends RuntimeException {
    public BairroEmpresaAlreadyRegisteredException() {
        super("Este bairro já está cadastrado para esta empresa");
    }
}
