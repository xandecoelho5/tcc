import 'package:e_markety_client/features/category/models/category.dart';
import 'package:e_markety_client/shared/widgets/category_circle_avatar.dart';
import 'package:e_markety_client/shared/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../shared/theme/constants.dart';
import '../../../shared/utils/modular_utils.dart';
import '../../../shared/widgets/action_cart.dart';
import '../../../shared/widgets/search_bar_with_filter.dart';
import '../blocs/product_by_category/product_by_category_bloc.dart';
import '../components/product_card.dart';

class ProductsByCategoryScreen extends StatelessWidget {
  const ProductsByCategoryScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  final Category category;

  Stack _imageContainer(context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(category.imageUrl),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                kMediumBrownColor.withOpacity(0.4),
                BlendMode.darken,
              ),
            ),
          ),
        ),
        Positioned(
          top: 40,
          left: MediaQuery.of(context).size.width * 0.5 - 48,
          child: CategoryCircleAvatar(
            category: category,
            outerRadius: 44,
            innerRadius: 38,
            iconSize: 48,
            filled: false,
          ),
        ),
      ],
    );
  }

  SliverAppBar _sliverAppBar(context) {
    return SliverAppBar(
      leading: CustomAppBar.leadingIcon(() => Modular.to.pop()),
      pinned: true,
      expandedHeight: 160,
      actions: const [ActionCart()],
      backgroundColor: category.color,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          category.name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        background: _imageContainer(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Modular.get<ProductByCategoryBloc>()
        .add(ProductGetAllByCategoryEvent(category.id));

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        slivers: <Widget>[
          _sliverAppBar(context),
          const SliverAppBar(
            leading: SizedBox(),
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: SearchBarWithFilter(),
            ),
          ),
          const _ProductsSliverList(),
        ],
      ),
    );
  }
}

class _ProductsSliverList extends StatelessWidget {
  const _ProductsSliverList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductByCategoryBloc, ProductByCategoryState>(
      bloc: Modular.get<ProductByCategoryBloc>(),
      builder: (context, state) {
        if (state is ProductByCategoryLoaded) {
          if (state.products.isEmpty) {
            return SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: Text(
                    'Nenhum produto encontrado para esta categoria',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ),
            );
          }
          return SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 0.77,
            ),
            delegate: SliverChildBuilderDelegate(
              childCount: state.products.length,
              (_, i) => Padding(
                padding: EdgeInsets.only(
                  left: i.isEven ? 16 : 0,
                  right: i.isOdd ? 16 : 0,
                ),
                child: ProductCard(product: state.products[i]),
              ),
            ),
          );
        }
        if (state is ProductByCategoryError) {
          ModularUtils.showError(state.message);
        }
        if (state is ProductByCategoryLoading) {
          return const SliverToBoxAdapter(child: CircularProgressIndicator());
        }
        return const SliverToBoxAdapter(child: Text('Algo deu errado....!'));
      },
    );
  }
}
