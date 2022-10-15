import 'package:dartz/dartz.dart';
import 'package:e_markety_client/features/category/services/category_exception.dart';

import '../../../core/services/http/http_service.dart';
import '../models/category.dart';

abstract class ICategoryService {
  Future<Either<CategoryException, List<Category>>> getCategories();

  Future<Either<CategoryException, Category>> getCategory(int id);
}

class CategoryService implements ICategoryService {
  final IHttpService _httpService;

  CategoryService(this._httpService);

  @override
  Future<Either<CategoryException, List<Category>>> getCategories() async {
    final response = await _httpService.getAll('/categoria');
    return response.fold(
      (l) => Left(CategoryException(l.message, l.stackTrace)),
      (r) => Right(r.map(Category.fromMap).toList()),
    );
  }

  @override
  Future<Either<CategoryException, Category>> getCategory(int id) async {
    final either = await _httpService.get('/categoria/$id');
    return either.fold(
      (l) => Left(CategoryException(l.message, l.stackTrace)),
      (r) => Right(Category.fromMap(r)),
    );
  }
}
