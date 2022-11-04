package br.edu.utfpr.e_markety.config.security.service.impl;

import br.edu.utfpr.e_markety.config.security.service.TokenService;
import br.edu.utfpr.e_markety.model.Usuario;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

import java.util.Date;

@Service
public class TokenServiceImpl implements TokenService {

    @Value("${jwt.expiration}")
    private String expiration;

    @Value("${jwt.secret}")
    private String secret;

    @Override
    public String generateToken(Authentication authentication, Long empresaId) {
        Usuario logged = (Usuario) authentication.getPrincipal();
        Date today = new Date();
        Date expirationDate = new Date(today.getTime() + Long.parseLong(expiration));

        return Jwts.builder()
                .setIssuer("API e-Markety")
                .claim("usuarioId", logged.getId())
                .claim("empresaId", empresaId)
                .setIssuedAt(today)
                .setExpiration(expirationDate)
                .signWith(SignatureAlgorithm.HS256, secret)
                .compact();
    }

    @Override
    public boolean isValidToken(String token) {
        if (token == null || token.isEmpty()) return false;

        try {
            Jwts.parser().setSigningKey(secret).parseClaimsJws(token);
            return true;
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return false;
        }
    }

    @Override
    public Long getUsuarioId(String token) {
        var claims = getClaims(token);
        return ((Integer) claims.get("usuarioId")).longValue();
    }

    @Override
    public Long getEmpresaId(String token) {
        var claims = getClaims(token);
        return ((Integer) claims.get("empresaId")).longValue();
    }

    private Claims getClaims(String token) {
        return Jwts.parser().setSigningKey(secret).parseClaimsJws(token).getBody();
    }
}
