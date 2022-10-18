import 'package:flutter/material.dart';

import '../theme/constants.dart';

class SearchBarWithFilter extends StatelessWidget {
  const SearchBarWithFilter({Key? key}) : super(key: key);

  Expanded _searchBar() {
    return const Expanded(
      flex: 7,
      child: Padding(
        padding: EdgeInsets.only(left: 14),
        child: TextField(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 18),
            hintText: 'Procurar por produtos...',
            filled: true,
            fillColor: kBackgroundColor,
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Icon(Icons.search, color: kBasicDarkColor, size: 28),
            ),
            suffixIcon: Padding(
              padding: EdgeInsets.only(left: 8, right: 16),
              child: CircleAvatar(
                radius: 12,
                backgroundColor: kBasicLightColor,
                child: Icon(Icons.close, color: kBasicDarkColor, size: 14),
              ),
            ),
            hintStyle: TextStyle(color: Colors.grey),
          ),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
      ),
    );
  }

  _filter() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(0, 52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: () {},
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
          child: _filter(),
        ),
        // _filter(),
      ],
    );
  }
}
