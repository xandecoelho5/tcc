import 'package:e_markety_client/features/category/models/category.dart';
import 'package:e_markety_client/shared/widgets/category_circle_avatar.dart';
import 'package:e_markety_client/shared/widgets/custom_app_bar.dart';
import 'package:e_markety_client/shared/widgets/search_bar_with_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/services/snack_bar/snackbar_service.dart';
import '../blocs/product_by_category/product_by_category_bloc.dart';
import '../components/products_list.dart';

class ProductsByCategoryScreen extends StatelessWidget {
  const ProductsByCategoryScreen({Key? key, required this.category})
      : super(key: key);

  final Category category;

  Container _imageContainer() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(category.imageUrl),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            category.color.withOpacity(0.75),
            BlendMode.darken,
          ),
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
    );
  }

  SizedBox _header(context) {
    return SizedBox(
      height: 280,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          _imageContainer(),
          Positioned(
            top: 120,
            left: MediaQuery.of(context).size.width * 0.5 - 65,
            child: CategoryCircleAvatar(
              category: category,
              outerRadius: 72,
              innerRadius: 60,
              iconSize: 85,
              filled: false,
            ),
          ),
          Positioned(
            top: 40,
            width: 270,
            child: Text(
              category.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.buildAppBar(
        context,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          _header(context),
          const SearchBarWithFilter(),
          const SizedBox(height: 8),
          Expanded(
            child: BlocBuilder<ProductByCategoryBloc, ProductByCategoryState>(
              bloc: Modular.get<ProductByCategoryBloc>()
                ..add(ProductGetAllByCategoryEvent(category.id)),
              builder: (context, state) {
                if (state is ProductByCategoryLoaded) {
                  if (state.products.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Center(
                        child: Text(
                          'Nenhum produto encontrado para esta categoria',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                    );
                  }
                  return ProductsList(products: state.products);
                }
                if (state is ProductByCategoryError) {
                  Modular.get<ISnackBarService>().showError(
                    context,
                    state.message,
                  );
                }
                if (state is ProductByCategoryLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return const Center(child: Text('Algo deu errado....!'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
