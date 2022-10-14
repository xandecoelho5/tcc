package br.edu.utfpr.e_markety.service.impl;

import br.edu.utfpr.e_markety.service.MapperService;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ModelMapperServiceImpl implements MapperService {

    private final ModelMapper mapper;

    @Override
    public <T, Y> Y mapEntityToDto(T entity, Class<Y> dtoClass) {
        return mapper.map(entity, dtoClass);
    }

    @Override
    public <T, Y> T mapDtoToEntity(Y dto, Class<T> entityClass) {
        return mapper.map(dto, entityClass);
    }

    @Override
    public <T, Y> List<Y> mapEntityListToDto(List<T> entityList, Class<Y> dtoClass) {
        return entityList.stream()
                .map(entity -> mapEntityToDto(entity, dtoClass))
                .toList();
    }

    @Override
    public <T, Y> List<T> mapDtoListToEntity(List<Y> dtoList, Class<T> entityClass) {
        return dtoList.stream()
                .map(dto -> mapDtoToEntity(dto, entityClass))
                .toList();
    }
}
