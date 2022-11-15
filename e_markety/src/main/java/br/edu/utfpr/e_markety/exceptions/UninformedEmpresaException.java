package br.edu.utfpr.e_markety.exceptions;

public class UninformedEmpresaException extends RuntimeException {

    public UninformedEmpresaException() {
        super("Empresa não informada");
    }
}
