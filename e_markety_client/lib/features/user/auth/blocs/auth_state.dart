part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthInitial implements AuthState {}

class AuthLogging implements AuthState {}

class AuthLogged implements AuthState {
  final User user;

  AuthLogged(this.user);
}

class AuthSignedOut implements AuthState {}

class AuthError implements AuthState {
  final String message;

  AuthError(this.message);
}
