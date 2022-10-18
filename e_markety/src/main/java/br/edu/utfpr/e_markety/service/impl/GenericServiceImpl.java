package br.edu.utfpr.e_markety.service.impl;

import br.edu.utfpr.e_markety.repository.GenericRepository;
import br.edu.utfpr.e_markety.service.GenericService;
import br.edu.utfpr.e_markety.service.MapperService;
import org.modelmapper.ModelMapper;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.transaction.annotation.Transactional;

import java.lang.reflect.ParameterizedType;
import java.util.List;
import java.util.Optional;

public abstract class GenericServiceImpl<T, ID, Y> implements GenericService<T, ID, Y> {

    protected abstract GenericRepository<T, ID> getRepository();

    private final MapperService mapper;
    private final Class<T> entityClass;
    private final Class<Y> dtoClass;

    protected GenericServiceImpl() { //MapperService mapper
        this.mapper = new ModelMapperServiceImpl(new ModelMapper());
        this.entityClass = (Class<T>) ((ParameterizedType) getClass().getGenericSuperclass()).getActualTypeArguments()[0];
        this.dtoClass = (Class<Y>) ((ParameterizedType) getClass().getGenericSuperclass()).getActualTypeArguments()[2];
    }

    @Override
    @Transactional(readOnly = true)
    public List<Y> getAll() {
        List<T> list = getRepository().findAll();
        return mapEntityListToDto(list);
    }

    @Override
    @Transactional(readOnly = true)
    public Page<Y> getAll(Pageable pageable) {
        Page<T> page = getRepository().findAll(pageable);
        return page.map(this::mapEntityToDto);
    }

    @Override
    public Y save(Y dto) {
        return save(dto, null);
    }

    @Override
    public Optional<Y> update(ID id, Y dto) {
        if (getRepository().findById(id).isPresent()) {
            return Optional.of(save(dto, id));
        }
        return Optional.empty();
    }

    private Y save(Y dto, ID id) {
        T entity = mapDtoToEntity(dto);
        preSave(entity, id);
        entity = getRepository().save(entity);
        return mapEntityToDto(entity);
    }

    @Override
    @Transactional
    public Optional<Y> getById(ID id) {
        Optional<T> byId = getRepository().findById(id);
        return byId.map(this::mapEntityToDto);
    }

    @Override
    @Transactional
    public Optional<Boolean> delete(ID id) {
        if (getRepository().findById(id).isPresent()) {
            getRepository().deleteById(id);
            return Optional.of(true);
        }
        return Optional.empty();
    }

    protected void changeEntityId(ID id, T entity) {

    }

    protected void preSave(T entity, ID id) {
        if (id != null) {
            changeEntityId(id, entity);
        }
    }

    private Y mapEntityToDto(T entity) {
//        return mapper.map(entity, dtoClass);
        return mapper.mapEntityToDto(entity, dtoClass);
    }

    private T mapDtoToEntity(Y dto) {
        return mapper.mapDtoToEntity(dto, entityClass);
//        return mapper.map(dto, entityClass);
    }

    private List<Y> mapEntityListToDto(List<T> entityList) {
        return entityList.stream()
                .map(this::mapEntityToDto)
                .toList();
    }
}
