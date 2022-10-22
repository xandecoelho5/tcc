import 'package:e_markety_client/shared/utils/assets.dart';

class User {
  final int id;
  final String name;
  final String email;
  final String avatarUrl;
  final List<int> favouritesIds;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.avatarUrl,
    this.favouritesIds = const [],
  });

  const User.empty({
    this.id = 0,
    this.name = '',
    this.email = '',
    this.avatarUrl = Assets.avatarPlaceholderUrl,
    this.favouritesIds = const [],
  });

  bool isFavourite(int id) => favouritesIds.contains(id);

  User copyWith({
    String? name,
    String? email,
    String? password,
    String? avatarUrl,
    List<int>? favouritesIds,
  }) {
    return User(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      favouritesIds: favouritesIds ?? this.favouritesIds,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': name,
      'email': email,
      'imagemUrl': avatarUrl,
      'favoritosIds': favouritesIds,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['nome'],
      email: map['email'],
      avatarUrl: map['imagemUrl'],
      favouritesIds: List<int>.from(map['favoritosIds']),
    );
  }
}
