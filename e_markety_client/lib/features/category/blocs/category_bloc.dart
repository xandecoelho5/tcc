import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/category.dart';
import '../services/category_service.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final ICategoryService service;

  CategoryBloc(this.service) : super(CategoryInitial()) {
    on<CategoryGetAllEvent>(_onCategoryGetAllEvent);
  }

  _onCategoryGetAllEvent(CategoryGetAllEvent event, emit) async {
    emit(CategoryLoading());
    final either = await service.getCategories();
    return either.fold(
      (l) => emit(CategoryFailure(l.message)),
      (r) => emit(CategorySuccess(r)),
    );
  }
}
