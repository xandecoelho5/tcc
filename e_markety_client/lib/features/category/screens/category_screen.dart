import 'package:e_markety_client/features/category/components/category_list.dart';
import 'package:e_markety_client/shared/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../shared/utils/modular_utils.dart';
import '../blocs/category_bloc.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.buildAppBar(context, title: 'Categorias'),
      body: BlocBuilder<CategoryBloc, CategoryState>(
        bloc: Modular.get<CategoryBloc>()..add(CategoryGetAllEvent()),
        builder: (context, state) {
          if (state is CategoryLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CategoryLoaded) {
            return CategoryList(categories: state.categories);
          }

          if (state is CategoryError) {
            ModularUtils.showError(state.message);
          }

          return const Center(child: Text('Nenhuma categoria para mostrar!'));
        },
      ),
    );
  }
}
