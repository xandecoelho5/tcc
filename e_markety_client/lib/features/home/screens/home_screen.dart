import 'package:e_markety_client/core/services/snack_bar/snackbar_service.dart';
import 'package:e_markety_client/features/category/blocs/category_bloc.dart';
import 'package:e_markety_client/features/category/components/category_list.dart';
import 'package:e_markety_client/features/home/components/banners.dart';
import 'package:e_markety_client/features/home/components/home_app_bar.dart';
import 'package:e_markety_client/features/order/address/blocs/default_address/default_address_bloc.dart';
import 'package:e_markety_client/features/product/components/products_list.dart';
import 'package:e_markety_client/shared/widgets/search_bar_with_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../shared/mocks/mocks.dart';
import '../../product/blocs/product/product_bloc.dart';
import '../../user/auth/components/view_all_row.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Modular.get<DefaultAddressBloc>().add(DefaultAddressGetEvent());
      Modular.get<ProductBloc>().add(ProductGetAllEvent(4));
      Modular.get<CategoryBloc>().add(CategoryGetAllEvent(5));
    });
  }

  Column _categories(context) {
    return Column(
      children: [
        ViewAllRow(
          text: 'Categorias',
          onViewAll: () => Modular.to.pushNamed('/category'),
        ),
        const SizedBox(height: 8),
        BlocBuilder<CategoryBloc, CategoryState>(
          bloc: Modular.get<CategoryBloc>(),
          builder: (context, state) {
            if (state is CategoryLoaded) {
              return CategoryList(categories: state.categories, needWrap: true);
            }
            if (state is CategoryError) {
              Modular.get<ISnackBarService>().showError(context, state.message);
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ],
    );
  }

  Column _bestSellers() {
    return Column(
      children: [
        const ViewAllRow(text: 'Mais Vendidos'),
        BlocBuilder<ProductBloc, ProductState>(
          bloc: Modular.get<ProductBloc>(),
          builder: (context, state) {
            if (state is ProductLoaded) {
              return ProductsList(products: state.products, needWrap: true);
            }
            if (state is ProductError) {
              Modular.get<ISnackBarService>().showError(context, state.message);
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar.build(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            const SearchBarWithFilter(),
            const SizedBox(height: 32),
            const Banners(items: bannersMock),
            const SizedBox(height: 24),
            _categories(context),
            const SizedBox(height: 16),
            _bestSellers(),
            const SizedBox(height: 16),
            // _popularProducts(),
          ],
        ),
      ),
    );
  }
}
