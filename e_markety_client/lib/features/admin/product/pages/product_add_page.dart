import 'package:e_markety_client/features/admin/product/components/product_container.dart';
import 'package:e_markety_client/shared/utils/modular_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../product/models/product.dart';
import '../blocs/admin_product_bloc.dart';

class ProductAddPage extends StatelessWidget {
  const ProductAddPage({Key? key}) : super(key: key);

  void _onSubmit(Product product) {
    Modular.get<AdminProductBloc>().add(ProductAddEvent(product));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdminProductBloc, AdminProductState>(
      bloc: Modular.get<AdminProductBloc>(),
      listener: (context, state) {
        if (state is AdminProductSuccess) {
          ModularUtils.showSuccess('Produto salvo');
          Modular.to.navigate('/admin/product');
        }
        if (state is AdminProductError) {
          ModularUtils.showError('Erro ao salvar produto: ${state.message}');
        }
      },
      child: ProductContainer(
        product: const Product.empty(),
        onSubmitProduct: _onSubmit,
        title: 'Adicionar Produto',
        buttonText: 'Cadastrar',
      ),
    );
  }
}
