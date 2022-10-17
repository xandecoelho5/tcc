import 'package:e_markety_client/features/user/models/register_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/user_service.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final IUserService _service;

  UserBloc(this._service) : super(UserInitial()) {
    on<UserRegisterEvent>(_onUserRegisterEvent);
  }

  Future<void> _onUserRegisterEvent(UserRegisterEvent event, emit) async {
    emit(UserLoading());
    final response = await _service.register(event.user);
    return response.fold(
      (l) => emit(UserError(l.message)),
      (r) => emit(UserSuccess()),
    );
  }
}
