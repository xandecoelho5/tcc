part of 'user_bloc.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserSuccess extends UserState {}

class UserUpdated extends UserState {}

class UserPasswordUpdated extends UserState {}

class UserError extends UserState {
  final String message;

  UserError(this.message);
}
