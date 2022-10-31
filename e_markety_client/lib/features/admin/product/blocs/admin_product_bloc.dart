import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../product/models/product.dart';
import '../../../product/services/product_service.dart';

part 'admin_product_event.dart';
part 'admin_product_state.dart';

class AdminProductBloc extends Bloc<AdminProductEvent, AdminProductState> {
  final IProductService _service;

  AdminProductBloc(this._service) : super(AdminProductInitial()) {
    on<ProductGetByIdEvent>(_onProductGetByIdEvent);
    on<ProductAddEvent>(_onProductAddEvent);
    on<ProductEditEvent>(_onProductEditEvent);
  }

  Future<void> _onProductGetByIdEvent(ProductGetByIdEvent event, emit) async {
    emit(AdminProductLoading());
    final response = await _service.getProductById(event.id);
    response.fold(
      (l) => emit(AdminProductError(l.message)),
      (r) => emit(AdminProductLoaded(r)),
    );
  }

  Future<void> _onProductAddEvent(ProductAddEvent event, emit) async {
    emit(AdminProductLoading());
    final response = await _service.addProduct(event.product);
    response.fold(
      (l) => emit(AdminProductError(l.message)),
      (r) => emit(AdminProductSuccess()),
    );
  }

  Future<void> _onProductEditEvent(ProductEditEvent event, emit) async {
    emit(AdminProductLoading());
    final response = await _service.editProduct(event.product);
    response.fold(
      (l) => emit(AdminProductError(l.message)),
      (r) => emit(AdminProductSuccess()),
    );
  }
}
