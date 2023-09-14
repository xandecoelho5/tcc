import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_markety_client/core/exceptions/dio_delete_exception.dart';
import 'package:e_markety_client/core/exceptions/dio_get_exception.dart';
import 'package:e_markety_client/core/exceptions/dio_patch_exception.dart';
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
      return Left(DioGetException(_handleError(e), e.stackTrace));
    }
  }

  @override
  Future<Either<BaseException, dynamic>> get(String url) async {
    try {
      final response = await _dio.get(url);
      return Right(response.data);
    } on DioError catch (e) {
      return Left(DioGetException(_handleError(e), e.stackTrace));
    }
  }

  @override
  Future<Either<BaseException, dynamic>> post(String url, dynamic body) async {
    try {
      final response = await _dio.post(url, data: body);
      return Right(response.data);
    } on DioError catch (e) {
      return Left(DioPostException(_handleError(e), e.stackTrace));
    }
  }

  @override
  Future<Either<BaseException, dynamic>> put(String url, dynamic body) async {
    try {
      final response = await _dio.put(url, data: body);
      return Right(response.data);
    } on DioError catch (e) {
      return Left(DioPutException(_handleError(e), e.stackTrace));
    }
  }

  @override
  Future<Either<BaseException, dynamic>> delete(String url) async {
    try {
      final response = await _dio.delete(url);
      return Right(response.data);
    } on DioError catch (e) {
      return Left(DioDeleteException(_handleError(e), e.stackTrace));
    }
  }

  @override
  Future<Either<BaseException, dynamic>> patch(String url, dynamic body) async {
    try {
      final response = await _dio.patch(url, data: body);
      return Right(response.data);
    } on DioError catch (e) {
      return Left(DioPatchException(_handleError(e), e.stackTrace));
    }
  }

  Future<Stream<dynamic>> getSream(String url) async {
    try {
      final response = await _dio.get(url);
      return response.data;
    } on DioError catch (e) {
      print(e);
      return const Stream.empty();
    }
  }

  String _handleError(DioError e) {
    if (e.response == null) return e.message;
    final data = e.response?.data;
    if (data is Map) {
      return data['message'] ?? data.toString();
    } else if (data is String) {
      return data;
    }
    return '';
  }
}
