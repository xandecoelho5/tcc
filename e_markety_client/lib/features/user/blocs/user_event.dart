part of 'user_bloc.dart';

abstract class UserEvent {}

class UserRegisterEvent extends UserEvent {
  final User user;

  UserRegisterEvent(this.user);
}
