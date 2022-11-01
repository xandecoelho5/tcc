package br.edu.utfpr.e_markety.exceptions;

public class NotFoundException extends RuntimeException {

    public NotFoundException(Long id) {
        super("Não foi encontrado o registro com o id: " + id);
    }
}
