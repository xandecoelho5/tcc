part of 'user_bloc.dart';

abstract class UserEvent {}

class UserRegisterEvent implements UserEvent {
  final RegisterModel user;

  UserRegisterEvent(this.user);
}

class UserUpdateEvent implements UserEvent {
  final User user;

  UserUpdateEvent(this.user);
}
