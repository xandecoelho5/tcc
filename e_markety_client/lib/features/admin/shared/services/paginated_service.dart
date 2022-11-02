import 'package:dartz/dartz.dart';
import 'package:e_markety_client/core/exceptions/base_exception.dart';
import 'package:e_markety_client/features/admin/shared/data_responses/page_response.dart';

abstract class IPaginatedService {
  Future<Either<BaseException, PageResponse>> getPaginated({
    required int page,
    required int size,
    String? order,
    bool? asc,
  });
}
