import 'package:e_markety_client/core/services/snack_bar/snackbar_service.dart';
import 'package:e_markety_client/features/category/blocs/category_bloc.dart';
import 'package:e_markety_client/features/category/components/category_list.dart';
import 'package:e_markety_client/features/company/blocs/company/company_bloc.dart';
import 'package:e_markety_client/features/home/components/banners.dart';
import 'package:e_markety_client/features/home/components/home_app_bar.dart';
import 'package:e_markety_client/features/order/address/blocs/default_address/default_address_bloc.dart';
import 'package:e_markety_client/features/order/shopping_cart/blocs/overview/cart_item_overview_bloc.dart';
import 'package:e_markety_client/features/product/components/products_list.dart';
import 'package:e_markety_client/features/product/models/product.dart';
import 'package:e_markety_client/shared/utils/modular_utils.dart';
import 'package:e_markety_client/shared/widgets/search_bar_with_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../product/blocs/product/product_bloc.dart';
import '../../user/auth/components/view_all_row.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final snackBarService = Modular.get<ISnackBarService>();
  final productBloc = Modular.get<ProductBloc>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Modular.get<CompanyBloc>().add(CompanyGetCurrentEvent());
      Modular.get<DefaultAddressBloc>().add(DefaultAddressGetEvent());
      productBloc.add(
        ProductGetPageEvent(
          page: 0,
          size: 4,
          order: 'quantidadeVendida',
          asc: false,
        ),
      );
      Modular.get<CategoryBloc>().add(CategoryGetAllEvent());
      Modular.get<CartItemOverviewBloc>()
          .add(const CartItemOverviewSubscriptionRequested());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar.build(context),
      body: BlocListener<CartItemOverviewBloc, CartItemOverviewState>(
        bloc: Modular.get<CartItemOverviewBloc>(),
        listenWhen: (previous, current) {
          if ((previous.status == CartItemOverviewStatus.loading &&
                  current.status == CartItemOverviewStatus.success) ||
              (current.cartItems.length <= previous.cartItems.length)) {
            return false;
          }
          return true;
        },
        listener: (context, state) {
          if (state.status == CartItemOverviewStatus.failure) {
            ModularUtils.showError('Erro ao carregar os itens do carrinho!');
          }
          if (state.status == CartItemOverviewStatus.success) {
            ModularUtils.showSuccess('Produto adicionado ao carrinho');
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16),
              const SearchBarWithFilter(),
              const SizedBox(height: 24),
              const _Banners(),
              const SizedBox(height: 16),
              const _Categories(),
              const SizedBox(height: 16),
              _BestSellers(productBloc),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _Banners extends StatelessWidget {
  const _Banners({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyBloc, CompanyState>(
      bloc: Modular.get<CompanyBloc>(),
      builder: (context, state) {
        if (state is CompanyLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is CompanyLoadedCurrentState) {
          return Banners(items: state.company.banners);
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _Categories extends StatelessWidget {
  const _Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ViewAllRow(
          text: 'Categorias',
          onViewAll: () => Modular.to.pushNamed('/category/'),
        ),
        const SizedBox(height: 4),
        BlocBuilder<CategoryBloc, CategoryState>(
          bloc: Modular.get<CategoryBloc>(),
          builder: (context, state) {
            if (state is CategoryLoaded) {
              return CategoryList(categories: state.categories, needWrap: true);
            }
            if (state is CategoryError) {
              ModularUtils.showError(state.message);
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ],
    );
  }
}

class _BestSellers extends StatelessWidget {
  const _BestSellers(this.productBloc, {Key? key}) : super(key: key);

  final ProductBloc productBloc;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ViewAllRow(
          text: 'Mais Vendidos',
          onViewAll: () => Modular.to.pushNamed('/product/best-sellers'),
        ),
        const SizedBox(height: 4),
        BlocBuilder<ProductBloc, ProductState>(
          bloc: productBloc,
          builder: (context, state) {
            if (state is ProductPageLoaded) {
              return ProductsList(
                products: state.pageResponse.content as List<Product>,
                needWrap: true,
              );
            }
            if (state is ProductError) {
              ModularUtils.showError(state.message);
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ],
    );
  }
}
