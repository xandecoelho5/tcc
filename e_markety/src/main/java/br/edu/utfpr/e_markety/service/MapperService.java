package br.edu.utfpr.e_markety.service;

import java.util.List;

public interface MapperService {
    <T, Y> Y mapEntityToDto(T entity, Class<Y> dtoClass);
    <T, Y> T mapDtoToEntity(Y dto, Class<T> entityClass);
    <T, Y> List<Y> mapEntityListToDto(List<T> entityList, Class<Y> dtoClass);
    <T, Y> List<T> mapDtoListToEntity(List<Y> dtoList, Class<T> entityClass);
}
