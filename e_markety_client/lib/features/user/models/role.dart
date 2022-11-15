enum Role {
  admin,
  client,
  employee;

  static Role fromString(String role) {
    switch (role.toUpperCase()) {
      case 'ADMIN':
        return Role.admin;
      case 'FUNCIONARIO':
        return Role.employee;
      default:
        return Role.client;
    }
  }
}
