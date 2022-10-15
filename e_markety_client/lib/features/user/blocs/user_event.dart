part of 'user_bloc.dart';

abstract class UserEvent {}

class UserRegisterEvent implements UserEvent {
  final User user;

  UserRegisterEvent(this.user);
}
