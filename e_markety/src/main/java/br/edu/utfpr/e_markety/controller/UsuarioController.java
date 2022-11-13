package br.edu.utfpr.e_markety.controller;

import br.edu.utfpr.e_markety.config.security.dto.SenhaDto;
import br.edu.utfpr.e_markety.config.security.dto.UsuarioDto;
import br.edu.utfpr.e_markety.config.security.dto.UsuarioEditDto;
import br.edu.utfpr.e_markety.config.security.service.UsuarioService;
import br.edu.utfpr.e_markety.config.validator.CustomValidator;
import br.edu.utfpr.e_markety.dto.FavoritoDto;
import br.edu.utfpr.e_markety.exceptions.InvalidLoggedUserException;
import br.edu.utfpr.e_markety.exceptions.UserAlreadyRegisteredException;
import br.edu.utfpr.e_markety.service.MapperService;
import br.edu.utfpr.e_markety.service.ProdutoService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;
import java.util.Map;

import static br.edu.utfpr.e_markety.utils.PrincipalUtils.getLoggedUsuario;

@RestController
@RequiredArgsConstructor
@RequestMapping("/usuario")
public class UsuarioController {

    private final UsuarioService usuarioService;
    private final ProdutoService produtoService;
    private final MapperService mapper;

    @PostMapping
    public ResponseEntity<?> register(@RequestBody @Valid UsuarioDto usuarioDto) {
        try {
            usuarioService.verifyUserExists(usuarioDto.getEmail());
            usuarioDto.setImagemUrl("http://unicietec.unievangelica.edu.br/wp-content/uploads/2017/04/avatar-placeholder-300x250.png");
            return ResponseEntity.ok(usuarioService.save(usuarioDto));
        } catch (UserAlreadyRegisteredException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @PutMapping
    public ResponseEntity<?> update(@RequestBody @Valid UsuarioEditDto dto) {
        try {
            var usuario = usuarioService.updateUsuario(dto);
            return ResponseEntity.ok(usuario);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    @PutMapping("/senha")
    public ResponseEntity<?> update(@RequestBody @Valid SenhaDto senhaDto) {
        try {
            usuarioService.updateSenha(senhaDto);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }

    @GetMapping
    public ResponseEntity<List<UsuarioDto>> getAll() {
        return ResponseEntity.ok(usuarioService.getAll());
    }

    @GetMapping("/current")
    public ResponseEntity<?> getCurrentUser() {
        var user = getLoggedUsuario();
        var userDto = mapper.mapEntityToDto(user, UsuarioDto.class);
        return ResponseEntity.ok(userDto);
    }

    @GetMapping("/favoritos")
    public ResponseEntity<?> getUserFavourites() {
        var user = getLoggedUsuario();
        return ResponseEntity.ok(produtoService.findAllByIdIn(user.getFavoritosIds()));
    }

    @PatchMapping("/favoritos")
    public ResponseEntity<?> addFavouriteToUser(@RequestBody FavoritoDto favoritoDto) {
        var user = getLoggedUsuario();
        if (user.getFavoritosIds().contains(favoritoDto.getId())) {
            user.getFavoritosIds().remove(favoritoDto.getId());
        } else {
            user.getFavoritosIds().add(favoritoDto.getId());
        }
        return ResponseEntity.ok(usuarioService.update(user.getId(), mapper.mapEntityToDto(user, UsuarioDto.class)));
    }

    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public Map<String, String> handleValidationExceptions(MethodArgumentNotValidException ex) {
        return CustomValidator.handleMethodArgumentNotValidException(ex);
    }

    @ResponseStatus(HttpStatus.UNAUTHORIZED)
    @ExceptionHandler(InvalidLoggedUserException.class)
    public String handleValidationExceptions(InvalidLoggedUserException ex) {
        return CustomValidator.handleCustomRuntimeException(ex);
    }
}
