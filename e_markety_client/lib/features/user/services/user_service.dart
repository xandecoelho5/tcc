import 'package:dartz/dartz.dart';
import 'package:e_markety_client/core/services/http/http_service.dart';
import 'package:e_markety_client/features/user/exceptions/user_exception.dart';
import 'package:e_markety_client/features/user/models/password.dart';
import 'package:e_markety_client/features/user/models/register_model.dart';

import '../models/user.dart';

abstract class IUserService {
  Future<Either<UserException, User>> getCurrentUser();

  Future<Either<UserException, void>> register(RegisterModel user);

  Future<Either<UserException, User>> updateUser(User user);

  Future<Either<UserException, void>> updatePassword(Password password);
}

class UserService implements IUserService {
  final IHttpService _httpService;
  final _baseUrl = '/usuario';

  UserService(this._httpService);

  @override
  Future<Either<UserException, void>> register(RegisterModel user) async {
    final response = await _httpService.post(_baseUrl, user.toMap());
    return response.fold(
      (l) => Left(UserException(l.message, l.stackTrace)),
      (r) => const Right(null),
    );
  }

  @override
  Future<Either<UserException, User>> updateUser(User user) async {
    final response = await _httpService.put(_baseUrl, user.toUserEditMap());
    return response.fold(
      (l) => Left(UserException(l.message, l.stackTrace)),
      (r) => Right(User.fromMap(r)),
    );
  }

  @override
  Future<Either<UserException, void>> updatePassword(Password password) async {
    final response = await _httpService.put(
      '$_baseUrl/senha',
      password.toMap(),
    );
    return response.fold(
      (l) => Left(UserException(l.message, l.stackTrace)),
      (r) => const Right(null),
    );
  }

  @override
  Future<Either<UserException, User>> getCurrentUser() async {
    final response = await _httpService.get('$_baseUrl/current');
    return response.fold(
      (l) => Left(UserException(l.message, l.stackTrace)),
      (r) => Right(User.fromMap(r)),
    );
  }
}
