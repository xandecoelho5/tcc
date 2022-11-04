package br.edu.utfpr.e_markety.config.security;

import br.edu.utfpr.e_markety.config.security.dto.PrincipalDto;
import br.edu.utfpr.e_markety.config.security.service.TokenService;
import br.edu.utfpr.e_markety.repository.EmpresaRepository;
import br.edu.utfpr.e_markety.repository.UsuarioRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@RequiredArgsConstructor
public class AuthByTokenFilter extends OncePerRequestFilter {

    private final TokenService tokenService;
    private final UsuarioRepository usuarioRepository;
    private final EmpresaRepository empresaRepository;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        String token = getToken(request);

        if (tokenService.isValidToken(token)) {
            authenticateUser(token);
        }

        filterChain.doFilter(request, response);
    }

    private void authenticateUser(String token) {
        Long usuarioId = tokenService.getUsuarioId(token);
        Long empresaId = tokenService.getEmpresaId(token);

        var optionalUsuario = usuarioRepository.findById(usuarioId);
        var optionalEmpresa = empresaRepository.findById(empresaId);
        if (optionalUsuario.isPresent() && optionalEmpresa.isPresent()) {
            var principal = new PrincipalDto(optionalUsuario.get(), optionalEmpresa.get());
            var authentication = new UsernamePasswordAuthenticationToken(principal, null, principal.getUsuario().getAuthorities());
            SecurityContextHolder.getContext().setAuthentication(authentication);
        }
    }

    private String getToken(HttpServletRequest request) {
        String token = request.getHeader("Authorization");
        if (token == null || !token.startsWith("Bearer ")) {
            return null;
        }

        return token.substring(7);
    }
}
