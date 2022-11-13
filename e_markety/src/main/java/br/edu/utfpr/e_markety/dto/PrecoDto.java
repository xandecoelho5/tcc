package br.edu.utfpr.e_markety.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;

import java.math.BigDecimal;

@Getter
@AllArgsConstructor
public class PrecoDto {

    private BigDecimal min;
    private BigDecimal max;
}
