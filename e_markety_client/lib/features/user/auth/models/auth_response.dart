class AuthResponse {
  final String token;
  final String type;

  const AuthResponse({
    required this.token,
    required this.type,
  });

  factory AuthResponse.fromMap(Map<String, dynamic> map) {
    return AuthResponse(
      token: map['token'],
      type: map['tipo'],
    );
  }
}
