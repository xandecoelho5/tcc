package br.edu.utfpr.e_markety.exceptions;

public class BairroNotFoundForEmpresaException extends RuntimeException {
    public BairroNotFoundForEmpresaException() {
        super("Este bairro não está cadastrado para esta empresa");
    }
}
