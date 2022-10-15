import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_markety_client/core/exceptions/dio_delete_exception.dart';
import 'package:e_markety_client/core/exceptions/dio_get_exception.dart';
import 'package:e_markety_client/core/exceptions/dio_post_exception.dart';
import 'package:e_markety_client/core/exceptions/dio_put_exception.dart';

import '../../exceptions/base_exception.dart';
import 'http_service.dart';

class DioService implements IHttpService {
  final Dio _dio;

  DioService(this._dio);

  @override
  Future<Either<BaseException, List>> getAll(String url) async {
    try {
      final response = await _dio.get(url);
      return Right(response.data);
    } on DioError catch (e) {
      return Left(DioGetException(e.message, e.stackTrace));
    }
  }

  @override
  Future<Either<BaseException, dynamic>> get(String url) async {
    try {
      final response = await _dio.get(url);
      return Right(response.data);
    } on DioError catch (e) {
      return Left(DioGetException(e.message, e.stackTrace));
    }
  }

  @override
  Future<Either<BaseException, dynamic>> post(String url, dynamic body) async {
    try {
      final response = await _dio.post(url, data: body);
      return Right(response.data);
    } on DioError catch (e) {
      return Left(DioPostException(e.message, e.stackTrace));
    }
  }

  @override
  Future<Either<BaseException, dynamic>> put(String url, dynamic body) async {
    try {
      final response = await _dio.put(url, data: body);
      return Right(response.data);
    } on DioError catch (e) {
      return Left(DioPutException(e.message, e.stackTrace));
    }
  }

  @override
  Future<Either<BaseException, dynamic>> delete(String url) async {
    try {
      final response = await _dio.delete(url);
      return Right(response.data);
    } on DioError catch (e) {
      return Left(DioDeleteException(e.message, e.stackTrace));
    }
  }
}
