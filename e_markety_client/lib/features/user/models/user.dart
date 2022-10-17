import 'package:e_markety_client/shared/utils/assets.dart';

class User {
  final int id;
  final String name;
  final String email;
  final String avatarUrl;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.avatarUrl,
  });

  const User.empty({
    this.id = 0,
    this.name = '',
    this.email = '',
    this.avatarUrl = Assets.avatarPlaceholderUrl,
  });

  User copyWith({
    String? name,
    String? email,
    String? password,
    String? avatarUrl,
  }) {
    return User(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': name,
      'email': email,
      'imagemUrl': avatarUrl,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['nome'],
      email: map['email'],
      avatarUrl: map['imagemUrl'],
    );
  }
}
