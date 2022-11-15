package br.edu.utfpr.e_markety.controller;

import br.edu.utfpr.e_markety.config.security.dto.LoginDto;
import br.edu.utfpr.e_markety.config.security.service.AuthService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.AuthenticationException;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;

@RestController
@RequiredArgsConstructor
@RequestMapping("/auth")
public class AuthController {

    private final AuthService authService;

    @PostMapping("/sign-in")
    public ResponseEntity<Object> authenticate(@RequestBody @Valid LoginDto loginDto) {
        try {
            return ResponseEntity.ok(authService.authenticate(loginDto));
        } catch (AuthenticationException e) {
            return ResponseEntity.badRequest().body("Credenciais incorretas!");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
}
