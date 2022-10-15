import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/category.dart';
import '../services/category_service.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final ICategoryService _service;

  CategoryBloc(this._service) : super(CategoryInitial()) {
    on<CategoryGetAllEvent>(_onCategoryGetAllEvent);
  }

  Future _onCategoryGetAllEvent(CategoryGetAllEvent event, emit) async {
    emit(CategoryLoading());
    final response = await _service.getCategories();
    return response.fold(
      (l) => emit(CategoryError(l.message)),
      (r) => emit(CategoryLoaded(r)),
    );
  }
}
