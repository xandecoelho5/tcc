import 'package:e_markety_client/features/product/blocs/filter/filter_bloc.dart';
import 'package:e_markety_client/shared/widgets/custom_app_bar.dart';
import 'package:e_markety_client/shared/widgets/search_bar_with_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../shared/theme/constants.dart';
import '../components/products_list.dart';

class SearchResultScreen extends StatelessWidget {
  const SearchResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.buildAppBar(
        context,
        title: 'Resultado da Pesquisa',
        onLeadingTap: () => Modular.to.navigate('/home/'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          const SearchBarWithFilter(),
          const SizedBox(height: 4),
          BlocBuilder<FilterBloc, FilterState>(
            bloc: Modular.get<FilterBloc>(),
            builder: (context, state) {
              if (state is FilterLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is FilterLoaded) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 8,
                  ),
                  child: Text(
                    "Resultado da pesquisa ${state.query.isEmpty ? '' : 'para ${state.query}'}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: kBasicDarkColor,
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          BlocBuilder(
            bloc: Modular.get<FilterBloc>(),
            builder: (context, state) {
              if (state is FilterLoaded) {
                if (state.products.isEmpty) {
                  return const Center(child: Text('Nenhum produto encontrado'));
                }
                return Expanded(child: ProductsList(products: state.products));
              }

              if (state is FilterError) {
                return Center(
                  child: Text('Erro ao carregar produtos ${state.message}'),
                );
              }

              if (state is FilterLoading) {
                return const Center(child: RefreshProgressIndicator());
              }

              return Container();
            },
          ),
        ],
      ),
    );
  }
}
