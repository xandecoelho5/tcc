package br.edu.utfpr.e_markety.dto;

import br.edu.utfpr.e_markety.model.Categoria;
import br.edu.utfpr.e_markety.model.Empresa;
import br.edu.utfpr.e_markety.model.UnidadeMedida;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.time.LocalDate;

@Getter
@Setter
@NoArgsConstructor
public class ProdutoDto {

    private Long id;

    @NotBlank(message = "Campo obrigatório")
    private String nome;

    @NotBlank(message = "Campo obrigatório")
    private String imagemUrl;

    @Length(max = 512, message = "Descrição muito longa")
    private String descricao = "";

    @NotNull(message = "Campo obrigatório")
    @Min(value = 0, message = "Preço deve ser maior que 0")
    private BigDecimal preco;

    private LocalDate dataCriacao;

    private LocalDate dataAtualizacao;

    private float estoque = 0;

    @Min(value = 0, message = "Desconto não pode ser menor que 0%")
    @Max(value = 100, message = "Desconto não pode ser maior que 100%")
    private int percentualDesconto = 0;

    @Min(value = 0, message = "Preço do peso deve ser maior ou igual a 0")
    @Max(value = 1, message = "Preço do peso deve ser menor ou igual a 1")
    private float pesoPreco;

    @Min(value = 0, message = "Peso da unidade deve ser maior ou igual a 0")
    @Max(value = 1, message = "Peso da unidade deve ser menor ou igual a 1")
    private float pesoUnidade;

    private float quantidadeVendida = 0;

    @NotNull(message = "Campo obrigatório")
    private UnidadeMedida unidadeMedida;

    @NotNull(message = "Campo obrigatório")
    private Categoria categoria;

    @JsonIgnore
    private Empresa empresa;

    @JsonIgnore
    public Empresa getEmpresa() {
        return empresa;
    }

    @JsonProperty
    public void setEmpresa(Empresa empresa) {
        this.empresa = empresa;
    }
}
