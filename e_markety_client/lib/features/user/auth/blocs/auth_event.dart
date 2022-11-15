part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AuthSignInEvent implements AuthEvent {
  final LoginModel login;

  AuthSignInEvent(this.login);
}

class AuthSignOutEvent implements AuthEvent {}

class AuthGetCurrentUserEvent implements AuthEvent {
  final Function()? onSuccessful;

  AuthGetCurrentUserEvent({this.onSuccessful});
}
