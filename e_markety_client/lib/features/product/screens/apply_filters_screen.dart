import 'package:e_markety_client/features/product/components/filter/price_range.dart';
import 'package:e_markety_client/features/product/components/filter/sort_category.dart';
import 'package:e_markety_client/features/product/components/filter/sort_options.dart';
import 'package:e_markety_client/shared/utils/global.dart';
import 'package:e_markety_client/shared/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../shared/theme/constants.dart';
import '../../../shared/widgets/filled_button.dart';
import '../blocs/filter/filter_bloc.dart';
import '../models/filter.dart';

class ApplyFiltersScreen extends StatelessWidget {
  const ApplyFiltersScreen({Key? key, required this.filter}) : super(key: key);

  final Filter filter;

  @override
  Widget build(BuildContext context) {
    var _filter = filter;

    void _onApply() {
      Modular.get<FilterBloc>().add(FilterApplyEvent(_filter));
      Modular.get<Global>().filter = _filter;
      Modular.to.navigate('/product/search-result');
    }

    return Scaffold(
      appBar: CustomAppBar.buildAppBar(context, title: 'Aplicar Filtros'),
      body: Column(
        children: [
          Expanded(
            flex: 9,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    PriceRange(
                      values: RangeValues(
                        _filter.values?.start ?? 0.0,
                        _filter.values?.end ?? 500.0,
                      ),
                      onPriceChanged: (values) {
                        _filter = _filter.copyWith(
                          values: RangeValues(values.start, values.end),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    SortOptions(
                      sortType: _filter.sortType,
                      onChangeSortType: (sortType) {
                        _filter = _filter.copyWith(sortType: sortType);
                      },
                    ),
                    const SizedBox(height: 20),
                    SortCategory(
                      category: _filter.category,
                      onChangeCategory: (category) {
                        if (category == null) {
                          _filter.category = null;
                        } else {
                          _filter = _filter.copyWith(category: category);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: FilledButton(
                text: 'Aplicar Filtros',
                color: kPrimaryColor,
                onPressed: _onApply,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
