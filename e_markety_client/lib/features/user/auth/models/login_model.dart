class LoginModel {
  final String login;
  final String password;
  final int? companyId;

  const LoginModel({
    required this.login,
    required this.password,
    this.companyId,
  });

  Map<String, dynamic> toMap() {
    return {
      'login': login,
      'senha': password,
      'empresaId': companyId,
    };
  }

  LoginModel copyWith({
    String? login,
    String? password,
    int? companyId,
  }) {
    return LoginModel(
      login: login ?? this.login,
      password: password ?? this.password,
      companyId: companyId ?? this.companyId,
    );
  }
}
