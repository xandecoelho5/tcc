import 'dart:async';

import 'package:e_markety_client/features/user/auth/models/login_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/user.dart';
import '../../services/user_service.dart';
import '../services/auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthService _authService;
  final IUserService _userService;

  AuthBloc(this._authService, this._userService) : super(AuthInitial()) {
    on<AuthSignInEvent>(_onAuthSignInEvent);
    on<AuthSignOutEvent>(_onAuthSignOutEvent);
    on<AuthGetCurrentUserEvent>(_onGetCurrentUser);
  }

  Future<void> _onAuthSignInEvent(AuthSignInEvent event, emit) async {
    emit(AuthLogging());
    final response = await _authService.signIn(event.login);
    await response.fold(
      (l) => emit(AuthError(l.message)),
      (r) => _onGetCurrentUser(event, emit),
    );
  }

  Future<void> _onAuthSignOutEvent(AuthSignOutEvent event, emit) async {
    await _authService.signOut();
    emit(AuthSignedOut());
  }

  Future<void> _onGetCurrentUser(event, emit) async {
    final user = await _userService.getCurrentUser();
    await user.fold(
      (l) => emit(AuthError(l.message)),
      (r) {
        emit(AuthLogged(r));
        event.onSuccessful?.call();
      },
    );
  }
}
