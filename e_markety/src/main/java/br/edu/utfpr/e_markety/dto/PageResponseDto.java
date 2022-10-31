package br.edu.utfpr.e_markety.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.data.domain.Page;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class PageResponseDto<T> {

    private List<T> content;
    private long totalElements;
    private int totalPages;
    private int size;

    public static <T> PageResponseDto<T> of(Page<T> page) {
        return new PageResponseDto<>(page.getContent(), page.getTotalElements(), page.getTotalPages(), page.getSize());
    }
}
