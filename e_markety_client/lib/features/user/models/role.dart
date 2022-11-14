enum Role {
  admin,
  user,
  companyAdmin;

  static Role fromString(String role) {
    switch (role.toUpperCase()) {
      case 'ADMIN':
        return Role.admin;
      case 'ADMIN_EMPRESA':
        return Role.companyAdmin;
      default:
        return Role.user;
    }
  }
}
