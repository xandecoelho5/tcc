package br.edu.utfpr.e_markety.controller;

import br.edu.utfpr.e_markety.config.security.dto.LoginDto;
import br.edu.utfpr.e_markety.config.security.dto.TokenDto;
import br.edu.utfpr.e_markety.config.security.dto.UsuarioDto;
import br.edu.utfpr.e_markety.config.security.service.TokenService;
import br.edu.utfpr.e_markety.config.security.service.UsuarioService;
import br.edu.utfpr.e_markety.config.validator.CustomValidator;
import br.edu.utfpr.e_markety.dto.FavoritoDto;
import br.edu.utfpr.e_markety.exceptions.InvalidLoggedUserException;
import br.edu.utfpr.e_markety.exceptions.UserAlreadyRegisteredException;
import br.edu.utfpr.e_markety.service.MapperService;
import br.edu.utfpr.e_markety.service.ProdutoService;
import br.edu.utfpr.e_markety.utils.PrincipalUtils;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.Map;

@RestController
@RequiredArgsConstructor
public class UsuarioController {

    private final AuthenticationProvider authProvider;
    private final UsuarioService usuarioService;
    private final TokenService tokenService;
    private final ProdutoService produtoService;
    private final MapperService mapper;

    @PostMapping("/auth/sign-in")
    public ResponseEntity<Object> authenticate(@RequestBody @Valid LoginDto loginDto) {
        try {
            UsernamePasswordAuthenticationToken loginData = loginDto.convert();
            Authentication authentication = authProvider.authenticate(loginData);
            String token = tokenService.generateToken(authentication, loginDto.getEmpresaId());

            return ResponseEntity.ok(new TokenDto(token, "Bearer"));
        } catch (AuthenticationException e) {
            return ResponseEntity.badRequest().body("Credenciais incorretas!");
        }
    }

    @PostMapping("/usuario")
    public ResponseEntity<Object> register(@RequestBody @Valid UsuarioDto usuarioDto) {
        try {
            usuarioService.verifyUserExists(usuarioDto.getEmail());
            usuarioDto.setImagemUrl("http://unicietec.unievangelica.edu.br/wp-content/uploads/2017/04/avatar-placeholder-300x250.png");
            return ResponseEntity.ok(usuarioService.save(usuarioDto));
        } catch (UserAlreadyRegisteredException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @GetMapping("/usuario")
    public ResponseEntity<Object> getAll() {
        return ResponseEntity.ok(usuarioService.getAll());
    }

    @GetMapping("/usuario/current")
    public ResponseEntity<?> getCurrentUser() {
        var user = PrincipalUtils.getLoggedUsuario();
        var userDto = mapper.mapEntityToDto(user, UsuarioDto.class);
        return ResponseEntity.ok(userDto);
    }

    @GetMapping("/usuario/favoritos")
    public ResponseEntity<?> getUserFavourites() {
        var user = PrincipalUtils.getLoggedUsuario();
        return ResponseEntity.ok(produtoService.findAllByIdIn(user.getFavoritosIds()));
    }

    @PatchMapping("/usuario/favoritos")
    public ResponseEntity<?> addFavouriteToUser(@RequestBody FavoritoDto favoritoDto) {
        var user = PrincipalUtils.getLoggedUsuario();
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
