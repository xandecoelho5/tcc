import 'package:e_markety_client/features/category/components/category_list.dart';
import 'package:e_markety_client/shared/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

import '../../../shared/mocks/mocks.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.buildAppBar(context, title: 'Categories'),
      body: const CategoryList(categories: categoriesMock),
    );
  }
}
