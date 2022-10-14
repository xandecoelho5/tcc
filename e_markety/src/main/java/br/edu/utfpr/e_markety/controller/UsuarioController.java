package br.edu.utfpr.e_markety.controller;

import br.edu.utfpr.e_markety.config.security.dto.LoginDto;
import br.edu.utfpr.e_markety.config.security.dto.TokenDto;
import br.edu.utfpr.e_markety.config.security.dto.UsuarioDto;
import br.edu.utfpr.e_markety.config.security.service.TokenService;
import br.edu.utfpr.e_markety.config.security.service.UsuarioService;
import br.edu.utfpr.e_markety.config.validator.CustomValidator;
import br.edu.utfpr.e_markety.model.Usuario;
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
import java.util.Optional;

@RestController
@RequiredArgsConstructor
public class UsuarioController {

    private final AuthenticationProvider authProvider;
    private final UsuarioService service;
    private final TokenService tokenService;

    @PostMapping("/auth")
    public ResponseEntity<Object> authenticate(@RequestBody @Valid LoginDto loginDto) {
        try {
            UsernamePasswordAuthenticationToken loginData = loginDto.convert();
            Authentication authentication = authProvider.authenticate(loginData);
            String token = tokenService.generateToken(authentication);

            return ResponseEntity.ok(new TokenDto(token, "Bearer"));
        } catch (AuthenticationException e) {
            return ResponseEntity.badRequest().body("Credenciais incorretas!");
        }
    }

    @PostMapping("/usuario")
    public ResponseEntity<Object> register(@RequestBody @Valid UsuarioDto usuarioDto) {
        Optional<Usuario> user = service.findByEmail(usuarioDto.getEmail());
        if (user.isPresent()) {
            return ResponseEntity.badRequest().body("Usuário já cadastrado");
        }
        return ResponseEntity.ok(service.save(usuarioDto));
    }

    @GetMapping("/usuario")
    public ResponseEntity<Object> getAll() {
        return ResponseEntity.ok(service.getAll());
    }

    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public Map<String, String> handleValidationExceptions(MethodArgumentNotValidException ex) {
        return CustomValidator.handleMethodArgumentNotValidException(ex);
    }
}
