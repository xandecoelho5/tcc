class LoginModel {
  final String login;
  final String password;

  const LoginModel({required this.login, required this.password});

  Map<String, dynamic> toMap() {
    return {
      'login': login,
      'senha': password,
    };
  }

  LoginModel copyWith({
    String? login,
    String? password,
  }) {
    return LoginModel(
      login: login ?? this.login,
      password: password ?? this.password,
    );
  }
}
