import 'package:e_markety_client/core/services/snack_bar/snackbar_service.dart';
import 'package:e_markety_client/features/admin/product/components/product_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../product/models/product.dart';
import '../blocs/admin_product_bloc.dart';

class ProductAddScreen extends StatelessWidget {
  const ProductAddScreen({Key? key}) : super(key: key);

  void _onSubmit(Product product) {
    Modular.get<AdminProductBloc>().add(ProductAddEvent(product));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdminProductBloc, AdminProductState>(
      bloc: Modular.get<AdminProductBloc>(),
      listener: (context, state) {
        if (state is AdminProductSuccess) {
          Modular.get<ISnackBarService>().showSuccess(context, 'Produto salvo');
          Future.delayed(
            const Duration(seconds: 1),
            () => Modular.to.navigate('/admin/product'),
          );
        }
        if (state is AdminProductError) {
          Modular.get<ISnackBarService>()
              .showError(context, 'Erro ao salvar produto: ${state.message}');
        }
      },
      child: ProductContainer(
        product: Product.empty(),
        onSubmitProduct: _onSubmit,
        title: 'Adicionar Produto',
        buttonText: 'Cadastrar',
      ),
    );
  }
}
