import 'package:dartz/dartz.dart';
import 'package:e_markety_client/core/services/http/http_service.dart';
import 'package:e_markety_client/features/user/exceptions/user_exception.dart';

import '../models/user.dart';

abstract class IUserService {
  // Future<User> getUser();
  Future<Either<UserException, void>> register(User user);

  Future<Either<UserException, User>> updateUser(User user);
}

class UserService implements IUserService {
  final IHttpService _httpService;

  UserService(this._httpService);

  @override
  Future<Either<UserException, void>> register(User user) async {
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
}
