package br.edu.utfpr.e_markety.service.impl;

import br.edu.utfpr.e_markety.exceptions.NotFoundException;
import br.edu.utfpr.e_markety.repository.GenericRepository;
import br.edu.utfpr.e_markety.repository.GenericUserRepository;
import br.edu.utfpr.e_markety.service.GenericService;
import br.edu.utfpr.e_markety.service.MapperService;
import org.modelmapper.ModelMapper;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.transaction.annotation.Transactional;

import java.lang.reflect.ParameterizedType;
import java.util.List;

import static br.edu.utfpr.e_markety.utils.PrincipalUtils.getLoggedUsuario;

public abstract class GenericServiceImpl<T, ID, Y> implements GenericService<ID, Y> {

    protected abstract GenericRepository<T, ID> getRepository();

    private final MapperService mapper;
    private final Class<T> entityClass;
    private final Class<Y> dtoClass;

    protected GenericServiceImpl() {
        this.mapper = new ModelMapperServiceImpl(new ModelMapper());
        this.entityClass = (Class<T>) ((ParameterizedType) getClass().getGenericSuperclass()).getActualTypeArguments()[0];
        this.dtoClass = (Class<Y>) ((ParameterizedType) getClass().getGenericSuperclass()).getActualTypeArguments()[2];
    }

    @Override
    @Transactional(readOnly = true)
    public List<Y> getAll() {
        List<T> list = getRepository() instanceof GenericUserRepository ? (List<T>) findAllByUsuario(null) : getRepository().findAll();
        return mapEntityListToDto(list);
    }

    @Override
    @Transactional(readOnly = true)
    public Page<Y> getAll(Pageable pageable) {
        Page<T> page = getRepository() instanceof GenericUserRepository ? (Page<T>) findAllByUsuario(pageable) : getRepository().findAll(pageable);
        return page.map(this::mapEntityToDto);
    }

    protected Iterable<T> findAllByUsuario(Pageable pageable) {
        var usuarioId = (ID) getLoggedUsuario().getId();
        var repository = (GenericUserRepository<T, ID>) getRepository();
        return pageable == null ? repository.findAllByUsuarioId(usuarioId) : repository.findAllByUsuarioId(usuarioId, pageable);
    }

    @Override
    @Transactional
    public Y save(Y dto) {
        return save(dto, null);
    }

    @Override
    @Transactional
    public Y update(ID id, Y dto) {
        findById(id);
        preUpdate(dto);
        return save(dto, id);
    }

    private Y save(Y dto, ID id) {
        var entity = mapDtoToEntity(dto);
        preSave(entity, id);
        entity = getRepository().save(entity);
        return mapEntityToDto(entity);
    }

    @Override
    @Transactional
    public Y getById(ID id) {
        var entity = findById(id);
        return mapEntityToDto(entity);
    }

    @Override
    @Transactional
    public void delete(ID id) {
        findById(id);
        preDelete(id);
        getRepository().deleteById(id);
    }

    protected void preUpdate(Y dto) {

    }

    protected void preSave(T entity, ID id) {
    }

    protected void preDelete(ID id) {
    }

    protected Y mapEntityToDto(T entity) {
        return mapper.mapEntityToDto(entity, dtoClass);
    }

    protected T mapDtoToEntity(Y dto) {
        return mapper.mapDtoToEntity(dto, entityClass);
    }

    protected List<Y> mapEntityListToDto(List<T> entityList) {
        return mapper.mapEntityListToDto(entityList, dtoClass);
    }

    protected T findById(ID id) {
        var byId = getRepository() instanceof GenericUserRepository ?
                ((GenericUserRepository<T, ID>) getRepository()).findByIdAndUsuarioId(id, (ID) getLoggedUsuario().getId()) :
                getRepository().findById(id);
        return byId.orElseThrow(() -> new NotFoundException((Long) id));
    }
}
