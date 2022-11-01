import 'package:dartz/dartz.dart';
import 'package:e_markety_client/core/services/http/http_service.dart';
import 'package:e_markety_client/features/product/models/filter.dart';
import 'package:e_markety_client/shared/data_responses/product_page_response.dart';

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

  Future<Either<ProductException, ProductPageResponse>> getProductsPaginated({
    required int page,
    required int size,
    String? order,
    bool? asc,
  });

  Future<Either<ProductException, Product>> getProductById(int id);

  Future<Either<ProductException, void>> addProduct(Product product);

  Future<Either<ProductException, void>> editProduct(Product product);

  Future<Either<ProductException, void>> deleteProduct(int id);
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

  @override
  Future<Either<ProductException, ProductPageResponse>> getProductsPaginated({
    required int page,
    required int size,
    String? order,
    bool? asc,
  }) async {
    final response =
        await _httpService.get('$_baseUrl/page?page=$page&size=$size'
            '${order != null ? '&order=$order' : ''}'
            '${asc != null ? '&asc=$asc' : ''}');
    return response.fold(
      (l) => Left(ProductException(l.message, l.stackTrace)),
      (r) => Right(ProductPageResponse.fromMap(r)),
    );
  }

  @override
  Future<Either<ProductException, void>> addProduct(Product product) async {
    final response = await _httpService.post(_baseUrl, product.toMap());
    return response.fold(
      (l) => Left(ProductException(l.message, l.stackTrace)),
      (r) => const Right(null),
    );
  }

  @override
  Future<Either<ProductException, void>> editProduct(Product product) async {
    final response =
        await _httpService.put('$_baseUrl/${product.id}', product.toMap());
    return response.fold(
      (l) => Left(ProductException(l.message, l.stackTrace)),
      (r) => const Right(null),
    );
  }

  @override
  Future<Either<ProductException, Product>> getProductById(int id) async {
    final response = await _httpService.get('$_baseUrl/$id');
    return response.fold(
      (l) => Left(ProductException(l.message, l.stackTrace)),
      (r) => Right(Product.fromMap(r)),
    );
  }

  @override
  Future<Either<ProductException, void>> deleteProduct(int id) async {
    final response = await _httpService.delete('$_baseUrl/$id');
    return response.fold(
      (l) => Left(ProductException(l.message, l.stackTrace)),
      (r) => const Right(null),
    );
  }
}
