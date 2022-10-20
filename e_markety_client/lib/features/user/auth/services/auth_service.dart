import 'package:dartz/dartz.dart';
import 'package:e_markety_client/core/services/http/http_service.dart';
import 'package:e_markety_client/features/user/auth/exceptions/auth_exception.dart';
import 'package:e_markety_client/shared/utils/strings.dart';

import '../../../../core/services/cache/cache_service.dart';
import '../models/auth_response.dart';
import '../models/login_model.dart';

abstract class IAuthService {
  Future<Either<AuthException, void>> signIn(LoginModel login);

  Future<void> signOut();
}

class AuthService implements IAuthService {
  final IHttpService _httpService;
  final ICacheService _cacheService;

  AuthService(this._httpService, this._cacheService);

  @override
  Future<Either<AuthException, void>> signIn(LoginModel login) async {
    final response = await _httpService.post('/auth/sign-in', login.toMap());
    return response.fold(
      (l) => Left(AuthException(l.message, l.stackTrace)),
      (r) async {
        final authResponse = AuthResponse.fromMap(r);
        await _cacheService.save(
          Strings.token,
          [authResponse.type, authResponse.token],
        );
        return const Right(null);
      },
    );
  }

  @override
  Future<void> signOut() async {
    await _cacheService.delete(Strings.token);
  }
}
