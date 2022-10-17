import 'package:dartz/dartz.dart';
import 'package:e_markety_client/core/services/http/http_service.dart';
import 'package:e_markety_client/features/user/exceptions/user_exception.dart';
import 'package:e_markety_client/features/user/models/register_model.dart';

import '../models/user.dart';

abstract class IUserService {
  Future<Either<UserException, User>> getCurrentUser();

  Future<Either<UserException, void>> register(RegisterModel user);

  Future<Either<UserException, User>> updateUser(User user);
}

class UserService implements IUserService {
  final IHttpService _httpService;

  UserService(this._httpService);

  @override
  Future<Either<UserException, void>> register(RegisterModel user) async {
    final response = await _httpService.post('/usuario', user.toMap());
    return response.fold(
      (l) => Left(UserException(l.message, l.stackTrace)),
      (r) => const Right(null),
    );
  }

  @override
  Future<Either<UserException, User>> updateUser(User user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

  @override
  Future<Either<UserException, User>> getCurrentUser() async {
    final response = await _httpService.get('/usuario/current');
    return response.fold(
      (l) => Left(UserException(l.message, l.stackTrace)),
      (r) => Right(User.fromMap(r)),
    );
  }
}
