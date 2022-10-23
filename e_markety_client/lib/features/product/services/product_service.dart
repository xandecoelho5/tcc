import 'package:dartz/dartz.dart';
import 'package:e_markety_client/core/services/http/http_service.dart';
import 'package:e_markety_client/features/product/models/filter.dart';

import '../exceptions/product_exception.dart';
import '../models/product.dart';

abstract class IProductService {
  Future<Either<ProductException, List<Product>>> getProducts(int? size);

  Future<Either<ProductException, List<Product>>> getProductsByCategory(
    int categoryId,
  );

  Future<Either<ProductException, List<Product>>> getProductsByFilter(
    Filter filter,
  );
}

class ProductService implements IProductService {
  final _baseUrl = '/produto';
  final IHttpService _httpService;

  ProductService(this._httpService);

  @override
  Future<Either<ProductException, List<Product>>> getProducts(int? size) async {
    final response = await _httpService.getAll('$_baseUrl?size=${size ?? 0}');
    return response.fold(
      (l) => Left(ProductException(l.message, l.stackTrace)),
      (r) => Right(r.map(Product.fromMap).toList()),
    );
  }

  @override
  Future<Either<ProductException, List<Product>>> getProductsByCategory(
    int categoryId,
  ) async {
    final response =
        await _httpService.getAll('$_baseUrl/categoria/$categoryId');
    return response.fold(
      (l) => Left(ProductException(l.message, l.stackTrace)),
      (r) => Right(r.map(Product.fromMap).toList()),
    );
  }

  @override
  Future<Either<ProductException, List<Product>>> getProductsByFilter(
    Filter filter,
  ) async {
    final response =
        await _httpService.post('$_baseUrl/filtro', filter.toMap());
    return response.fold(
      (l) => Left(ProductException(l.message, l.stackTrace)),
      (r) => Right((r as List).map(Product.fromMap).toList()),
    );
  }
}
