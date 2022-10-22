import 'package:e_markety_client/features/product/blocs/favourite/favourite_bloc.dart';
import 'package:e_markety_client/features/product/components/favourite_list.dart';
import 'package:e_markety_client/shared/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.buildAppBar(context, title: 'Meus Favoritos'),
      body: BlocBuilder<FavouriteBloc, FavouriteState>(
        bloc: Modular.get<FavouriteBloc>()
          ..add(
            const FavouriteSubscriptionRequested(),
          ),
        builder: (context, state) {
          if (state.status == FavouriteStatus.success) {
            if (state.products.isEmpty) {
              return const Center(child: Text('Nenhum produto favoritado'));
            }
            return FavouriteList(favourites: state.products);
          }

          if (state.status == FavouriteStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == FavouriteStatus.failure) {
            return const Center(child: Text('Erro ao carregar favoritos'));
          }

          return Container();
        },
      ),
    );
  }
}
