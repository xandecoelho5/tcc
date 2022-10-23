import 'package:e_markety_client/features/category/models/category.dart';
import 'package:e_markety_client/features/order/checkout/components/information_container.dart';
import 'package:e_markety_client/shared/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../category/blocs/category_bloc.dart';

class SortCategory extends StatefulWidget {
  const SortCategory({
    Key? key,
    this.category,
    required this.onChangeCategory,
  }) : super(key: key);

  final Category? category;
  final void Function(Category?) onChangeCategory;

  @override
  State<SortCategory> createState() => _SortCategoryState();
}

class _SortCategoryState extends State<SortCategory> {
  late Category? _category = widget.category;

  @override
  Widget build(BuildContext context) {
    return InformationContainer(
      title: 'Categorias',
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: BlocBuilder<CategoryBloc, CategoryState>(
          bloc: Modular.get<CategoryBloc>(),
          builder: (context, state) {
            if (state is CategoryLoaded) {
              return Wrap(
                spacing: 8,
                runSpacing: 10,
                children: state.categories.map(
                  (category) {
                    final selected = _category?.name == category.name;
                    return InkWell(
                      onTap: () {
                        setState(() {
                          if (_category == category) {
                            _category = null;
                          } else {
                            _category = category;
                          }
                          widget.onChangeCategory(_category);
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: selected ? kPrimaryColor : Colors.grey[300],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          category.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: selected ? Colors.white : Colors.grey[700],
                          ),
                        ),
                      ),
                    );
                  },
                ).toList(),
              );
            }

            if (state is CategoryLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return const Center(child: Text('Erro ao carregar categorias'));
          },
        ),
      ),
    );
  }
}
