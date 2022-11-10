import 'package:e_markety_client/features/user/auth/blocs/auth_bloc.dart';
import 'package:e_markety_client/features/user/models/password.dart';
import 'package:e_markety_client/features/user/models/register_model.dart';
import 'package:e_markety_client/features/user/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../services/user_service.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final IUserService _service;

  UserBloc(this._service) : super(UserInitial()) {
    on<UserRegisterEvent>(_onRegister);
    on<UserUpdateEvent>(_onUpdateUser);
    on<UserUpdatePasswordEvent>(_onUpdatePassword);
  }

  Future<void> _onRegister(UserRegisterEvent event, emit) async {
    emit(UserLoading());
    final response = await _service.register(event.user);
    return response.fold(
      (l) => emit(UserError(l.message)),
      (r) => emit(UserSuccess()),
    );
  }

  Future<void> _onUpdateUser(UserUpdateEvent event, emit) async {
    emit(UserLoading());
    final response = await _service.updateUser(event.user);
    return response.fold(
      (l) => emit(UserError(l.message)),
      (r) {
        emit(UserUpdated());
        Modular.get<AuthBloc>().add(AuthGetCurrentUserEvent());
      },
    );
  }

  Future<void> _onUpdatePassword(UserUpdatePasswordEvent event, emit) async {
    if (event.password.isValid) {
      emit(UserLoading());
      final response = await _service.updatePassword(event.password);
      return response.fold(
        (l) => emit(UserError(l.message)),
        (r) => emit(UserPasswordUpdated()),
      );
    }
  }
}
