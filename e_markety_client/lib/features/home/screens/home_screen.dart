import 'package:e_markety_client/core/services/snack_bar/snackbar_service.dart';
import 'package:e_markety_client/features/category/blocs/category_bloc.dart';
import 'package:e_markety_client/features/category/components/category_list.dart';
import 'package:e_markety_client/features/company/blocs/company/company_bloc.dart';
import 'package:e_markety_client/features/home/components/banners.dart';
import 'package:e_markety_client/features/home/components/home_app_bar.dart';
import 'package:e_markety_client/features/order/address/blocs/default_address/default_address_bloc.dart';
import 'package:e_markety_client/features/order/order/models/order_status.dart';
import 'package:e_markety_client/features/order/shopping_cart/blocs/overview/cart_item_overview_bloc.dart';
import 'package:e_markety_client/features/product/blocs/favourite/favourite_bloc.dart';
import 'package:e_markety_client/features/product/blocs/stock/stock_bloc.dart';
import 'package:e_markety_client/features/product/components/products_list.dart';
import 'package:e_markety_client/features/product/models/product.dart';
import 'package:e_markety_client/shared/utils/modular_utils.dart';
import 'package:e_markety_client/shared/widgets/search_bar_with_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../shared/utils/strings.dart';
import '../../order/order/blocs/current_order/current_order_bloc.dart';
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
  final cartItemBloc = Modular.get<CartItemOverviewBloc>();
  final favouriteBloc = Modular.get<FavouriteBloc>();

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
      cartItemBloc.add(const CartItemOverviewSubscriptionRequested());
      favouriteBloc.add(const FavouriteSubscriptionRequested());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar.build(context),
      body: MultiBlocListener(
        listeners: [
          BlocListener<StockBloc, StockState>(
            bloc: Modular.get<StockBloc>(),
            listener: (context, state) {
              if (state is StockError) {
                ModularUtils.showError(state.message);
              }
              if (state is StockSuccess) {
                final orderState = Modular.get<CurrentOrderBloc>().state;
                if (orderState is! CurrentOrderLoaded ||
                    orderState.order.status == OrderStatus.pending) {
                  cartItemBloc.add(CartItemOverviewCartItemAdd(state.cartItem));
                } else {
                  ModularUtils.showError(Strings.naoPossivelAdicionarItem);
                }
              }
            },
          ),
          BlocListener<CartItemOverviewBloc, CartItemOverviewState>(
            bloc: cartItemBloc,
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
                ModularUtils.showError('Erro com os itens do carrinho!');
              }
              if (state.status == CartItemOverviewStatus.success) {
                ModularUtils.showSuccess('Produto adicionado ao carrinho');
              }
            },
          ),
          BlocListener<FavouriteBloc, FavouriteState>(
            bloc: favouriteBloc,
            listenWhen: (previous, current) {
              if ((previous.status == FavouriteStatus.loading &&
                      current.status == FavouriteStatus.success) ||
                  (current.products.length <= previous.products.length)) {
                return false;
              }
              return true;
            },
            listener: (context, state) {
              if (state.status == FavouriteStatus.failure) {
                ModularUtils.showError('Erro com os favoritos!');
              }
              if (state.status == FavouriteStatus.success) {
                ModularUtils.showSuccess('Favorito adicionado');
              }
            },
          ),
        ],
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16),
              const SearchBarWithFilter(),
              const SizedBox(height: 24),
              const _Banners(),
              const SizedBox(height: 16),
              const _Categories(),
              const SizedBox(height: 4),
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
