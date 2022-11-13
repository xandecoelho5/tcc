package br.edu.utfpr.e_markety.dto;

import br.edu.utfpr.e_markety.model.Bairro;
import br.edu.utfpr.e_markety.model.Empresa;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;

@Getter
@Setter
@NoArgsConstructor
public class EmpresaBairroDto {

    private Long id;

    @JsonIgnore
    private Empresa empresa;

    @NotNull(message = "Campo obrigatório")
    private Bairro bairro;

    @NotNull(message = "Campo obrigatório")
    @Min(value = 0, message = "Preço deve ser maior ou igual a 0")
    private BigDecimal taxaEntrega;
}
