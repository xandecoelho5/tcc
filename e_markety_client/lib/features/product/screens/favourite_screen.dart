import 'package:e_markety_client/features/product/components/favourite_list.dart';
import 'package:e_markety_client/shared/mocks/mocks.dart';
import 'package:e_markety_client/shared/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.buildAppBar(context, title: 'My Favourite'),
      body: FavouriteList(
        favourites: productsMock.where((e) => e.isFavorite).toList(),
      ),
    );
  }
}
