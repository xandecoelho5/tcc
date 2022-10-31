import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/services/snack_bar/snackbar_service.dart';
import '../../../product/models/product.dart';
import '../blocs/admin_product_bloc.dart';
import '../components/product_container.dart';

class ProductEditScreen extends StatelessWidget {
  ProductEditScreen({Key? key, required this.id}) : super(key: key);

  final String id;
  final bloc = Modular.get<AdminProductBloc>();

  void _onSubmit(Product product) {
    bloc.add(ProductEditEvent(product));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdminProductBloc, AdminProductState>(
      bloc: bloc,
      listener: (context, state) {
        if (state is AdminProductSuccess) {
          Modular.get<ISnackBarService>()
              .showSuccess(context, 'Produto editado');
          Future.delayed(
            const Duration(seconds: 1),
            () => Modular.to.navigate('/admin/product'),
          );
        }
        if (state is AdminProductError) {
          Modular.get<ISnackBarService>()
              .showError(context, 'Erro: ${state.message}');
        }
      },
      child: BlocBuilder<AdminProductBloc, AdminProductState>(
        bloc: bloc..add(ProductGetByIdEvent(int.parse(id))),
        builder: (context, state) {
          if (state is AdminProductLoaded) {
            return ProductContainer(
              product: state.product,
              onSubmitProduct: _onSubmit,
              title: 'Editar Produto',
              buttonText: 'Editar',
            );
          }

          if (state is AdminProductLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Container();
        },
      ),
    );
  }
}
