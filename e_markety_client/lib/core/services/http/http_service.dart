// abstract class IHttpService {
//   Future<List<T>> getAll<T>(String url);
//   Future<T> get<T>(String url);
//   Future<T> post<T>(String url, dynamic body);
//   Future<T> put<T>(String url, dynamic body);
//   Future<T> delete<T>(String url);
// }

import 'package:dartz/dartz.dart';
import 'package:e_markety_client/core/exceptions/base_exception.dart';

abstract class IHttpService<T> {
  Future<Either<BaseException, List>> getAll(String url);
  Future<Either<BaseException, dynamic>> get(String url);
  Future<Either<BaseException, dynamic>> post(String url, dynamic body);
  Future<Either<BaseException, dynamic>> put(String url, dynamic body);
  Future<Either<BaseException, dynamic>> delete(String url);
}
