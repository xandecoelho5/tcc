part of 'user_bloc.dart';

abstract class UserEvent {}

class UserRegisterEvent implements UserEvent {
  final RegisterModel user;

  UserRegisterEvent(this.user);
}
