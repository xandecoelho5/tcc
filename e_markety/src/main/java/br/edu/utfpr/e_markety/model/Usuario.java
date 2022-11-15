package br.edu.utfpr.e_markety.model;

import br.edu.utfpr.e_markety.config.security.dto.UsuarioEditDto;
import br.edu.utfpr.e_markety.model.enums.Cargo;
import com.vladmihalcea.hibernate.type.array.ListArrayType;
import com.vladmihalcea.hibernate.type.basic.PostgreSQLEnumType;
import lombok.*;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.Type;
import org.hibernate.annotations.TypeDef;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import javax.persistence.*;
import javax.validation.constraints.Email;
import java.util.Collection;
import java.util.List;

@Entity
@Getter
@Setter
@NoArgsConstructor
@TypeDef(name = "list-array", typeClass = ListArrayType.class)
@TypeDef(name = "pgsql_enum", typeClass = PostgreSQLEnumType.class)
@Table(uniqueConstraints = @UniqueConstraint(columnNames = "email"))
public class Usuario implements UserDetails {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(length = 60, nullable = false)
    @Email
    private String email;

    @Column(length = 60, nullable = false)
    private String nome;

    @Column(length = 17)
    private String telefone;

    @Column(length = 512, nullable = false)
    private String senha;

    @Column(length = 2048, nullable = false)
    private String imagemUrl;

    @Enumerated(EnumType.STRING)
    @Column(columnDefinition = "cargo_enum DEFAULT 'CLIENTE'::cargo_enum")
    @Type(type = "pgsql_enum")
    private Cargo cargo;

    @Type(type = "list-array")
    @Column(name = "favoritos_ids", columnDefinition = "bigint[]")
    @ColumnDefault("ARRAY[]::bigint[]")
    private List<Long> favoritosIds;

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return List.of(new SimpleGrantedAuthority("ROLE_" + cargo.name()));
    }

    @Override
    public String getPassword() {
        return getSenha();
    }

    @Override
    public String getUsername() {
        return getEmail();
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }

    public void setFromUsuarioEdit(UsuarioEditDto editDto) {
        this.setNome(editDto.getNome());
        this.setEmail(editDto.getEmail());
        this.setTelefone(editDto.getTelefone());
        this.setImagemUrl(editDto.getImagemUrl());
    }
}
