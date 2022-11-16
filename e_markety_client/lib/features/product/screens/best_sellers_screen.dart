import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../shared/utils/modular_utils.dart';
import '../../../shared/widgets/custom_app_bar.dart';
import '../blocs/product/product_bloc.dart';
import '../components/products_list.dart';
import '../models/product.dart';

class BestSellersScreen extends StatefulWidget {
  const BestSellersScreen({Key? key}) : super(key: key);

  @override
  State<BestSellersScreen> createState() => _BestSellersScreenState();
}

class _BestSellersScreenState extends State<BestSellersScreen> {
  final productBloc = Modular.get<ProductBloc>();

  @override
  void initState() {
    super.initState();
    productBloc.add(
      ProductGetPageEvent(
        page: 0,
        size: 10,
        order: 'quantidadeVendida',
        asc: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.buildAppBar(title: 'Mais Vendidos'),
      body: BlocBuilder<ProductBloc, ProductState>(
        bloc: productBloc,
        builder: (context, state) {
          if (state is ProductPageLoaded) {
            return ProductsList(
              products: state.pageResponse.content as List<Product>,
            );
          }
          if (state is ProductError) {
            ModularUtils.showError(state.message);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
