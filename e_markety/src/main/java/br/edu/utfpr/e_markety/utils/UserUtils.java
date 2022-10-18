package br.edu.utfpr.e_markety.utils;

import br.edu.utfpr.e_markety.model.Usuario;
import org.springframework.security.core.context.SecurityContextHolder;

import java.util.Optional;

public class UserUtils {

    private UserUtils() {

    }

    public static Optional<Usuario> getLoggedUser() {
        var principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        return principal instanceof String ? Optional.empty() : Optional.of((Usuario) principal);
    }
}
