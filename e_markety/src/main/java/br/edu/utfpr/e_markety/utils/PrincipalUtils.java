package br.edu.utfpr.e_markety.utils;

import br.edu.utfpr.e_markety.config.security.dto.PrincipalDto;
import br.edu.utfpr.e_markety.exceptions.InvalidLoggedUserException;
import br.edu.utfpr.e_markety.model.Empresa;
import br.edu.utfpr.e_markety.model.Usuario;
import org.springframework.security.core.context.SecurityContextHolder;

public class PrincipalUtils {

    private PrincipalUtils() {
    }

    public static Usuario getLoggedUsuario() {
        return getPrincipal().getUsuario();
    }

    public static Empresa getLoggedEmpresa() {
        return getPrincipal().getEmpresa();
    }

    private static PrincipalDto getPrincipal() {
        var principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (principal instanceof String) {
            throw new InvalidLoggedUserException();
        }
        return (PrincipalDto) principal;
    }
}
