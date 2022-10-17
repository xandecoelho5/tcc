class RegisterModel {
  final String name;
  final String email;
  final String password;

  const RegisterModel({
    required this.name,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'nome': name,
      'email': email,
      'senha': password,
    };
  }

  RegisterModel copyWith({
    String? name,
    String? email,
    String? password,
  }) {
    return RegisterModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
