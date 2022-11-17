package br.edu.utfpr.e_markety.exceptions;

public class EnderecoUninformedException extends RuntimeException {
    public EnderecoUninformedException() {
        super("O campo de endereço é obrigatório para o tipo de entrega selecionado");
    }
}
