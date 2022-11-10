import 'package:e_markety_client/shared/utils/assets.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String name;
  final String email;
  final String? phone;
  final String avatarUrl;
  final List<int> favouritesIds;
  final bool? admin;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.avatarUrl,
    this.phone,
    this.favouritesIds = const [],
    this.admin,
  });

  const User.empty({
    this.id = 0,
    this.name = '',
    this.email = '',
    this.phone = '',
    this.avatarUrl = Assets.avatarPlaceholderUrl,
    this.favouritesIds = const [],
    this.admin,
  });

  bool isFavourite(int id) => favouritesIds.contains(id);

  bool get isAdmin => admin ?? false;

  User copyWith({
    String? name,
    String? email,
    String? phone,
    String? avatarUrl,
    List<int>? favouritesIds,
  }) {
    return User(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      favouritesIds: favouritesIds ?? this.favouritesIds,
      admin: admin,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': name,
      'email': email,
      'telefone': phone,
      'imagemUrl': avatarUrl,
      'favoritosIds': favouritesIds,
    };
  }

  Map<String, dynamic> toUserEditMap() {
    return {
      'nome': name,
      'email': email,
      'telefone': phone,
      'imagemUrl': avatarUrl,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['nome'],
      email: map['email'],
      phone: map['telefone'],
      avatarUrl: map['imagemUrl'],
      favouritesIds: List<int>.from(map['favoritosIds']),
      admin: map['admin'],
    );
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email, phone: $phone, avatarUrl: $avatarUrl, favouritesIds: $favouritesIds} admin: $admin';
  }

  @override
  List<Object?> get props => [id, email];
}
