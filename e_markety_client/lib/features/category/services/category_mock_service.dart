import 'package:dartz/dartz.dart';
import 'package:e_markety_client/features/category/exceptions/category_exception.dart';
import 'package:e_markety_client/features/category/models/category.dart';
import 'package:e_markety_client/features/category/services/category_service.dart';
import 'package:e_markety_client/shared/mocks/mocks.dart';

class CategoryMockService implements CategoryService {
  @override
  Future<Either<CategoryException, List<Category>>> getCategories(
    int? size,
  ) async {
    try {
      return Right(categoriesMock);
    } catch (e) {
      return Left(CategoryException('Errrro: $e'));
    }
  }

  @override
  Future<Either<CategoryException, Category>> getCategory(int id) async {
    try {
      return Right(categoriesMock[id]);
    } catch (e) {
      return Left(CategoryException('Errrro: $e'));
    }
  }
}
