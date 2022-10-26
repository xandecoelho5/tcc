import 'package:e_markety_client/features/product/blocs/filter/filter_bloc.dart';
import 'package:e_markety_client/features/product/models/filter.dart';
import 'package:e_markety_client/shared/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../theme/constants.dart';

class SearchBarWithFilter extends StatefulWidget {
  const SearchBarWithFilter({Key? key}) : super(key: key);

  @override
  State<SearchBarWithFilter> createState() => _SearchBarWithFilterState();
}

class _SearchBarWithFilterState extends State<SearchBarWithFilter> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.text = Modular.get<Global>().filter.name;
    });
  }

  void _onClear() {
    if (_controller.text.isNotEmpty) {
      _controller.clear();
      _onApply();
    }
  }

  void _onApply() {
    Modular.get<FilterBloc>().add(FilterApplyEvent(_filter));
    Modular.get<Global>().filter = _filter;
    Modular.to.navigate('/search-result');
  }

  Filter get _filter => Modular.get<Global>().filter.copyWith(
        name: _controller.text,
      );

  Expanded _searchBar() {
    return Expanded(
      flex: 7,
      child: Padding(
        padding: const EdgeInsets.only(left: 14),
        child: TextField(
          controller: _controller,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 18),
            hintText: 'Procurar por produtos...',
            filled: true,
            fillColor: kBackgroundColor,
            prefixIcon: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Icon(Icons.search, color: kBasicDarkColor, size: 28),
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(left: 8, right: 16),
              child: CircleAvatar(
                radius: 12,
                backgroundColor: kBasicLightColor,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: _onClear,
                    splashColor: kBasicDarkColor,
                    borderRadius: BorderRadius.circular(50),
                    child: const Padding(
                      padding: EdgeInsets.all(4),
                      child: Icon(
                        Icons.close,
                        color: kBasicDarkColor,
                        size: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            hintStyle: const TextStyle(color: Colors.grey),
          ),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
          onSubmitted: (value) => _onApply(),
        ),
      ),
    );
  }

  ElevatedButton _filterButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(0, 52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: () => Modular.to.pushNamed(
        '/apply-filters',
        arguments: _filter,
      ),
      child: const Icon(
        Icons.filter_alt_outlined,
        color: Colors.white,
        size: 28,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _searchBar(),
        const SizedBox(width: 16),
        Padding(
          padding: const EdgeInsets.only(right: 14),
          child: _filterButton(),
        ),
      ],
    );
  }
}
