package br.edu.utfpr.e_markety.utils;

import br.edu.utfpr.e_markety.exceptions.InvalidLoggedUserException;
import br.edu.utfpr.e_markety.model.Usuario;
import org.springframework.security.core.context.SecurityContextHolder;

public class UserUtils {

    private UserUtils() {
    }

    public static Usuario getLoggedUser() throws InvalidLoggedUserException {
        var principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (principal instanceof String) {
            throw new InvalidLoggedUserException();
        }
        return (Usuario) principal;
    }
}
