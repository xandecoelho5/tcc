import 'package:e_markety_client/features/product/screens/apply_filters_screen.dart';
import 'package:e_markety_client/features/product/screens/product_details_screen.dart';
import 'package:e_markety_client/features/product/screens/products_by_category_screen.dart';
import 'package:e_markety_client/features/product/screens/search_result_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProductModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/search-result',
          child: (context, args) => const SearchResultScreen(),
        ),
        ChildRoute(
          '/products-by-category',
          child: (context, args) =>
              ProductsByCategoryScreen(category: args.data),
        ),
        ChildRoute(
          '/product-details',
          child: (context, args) => ProductDetailsScreen(product: args.data),
        ),
        ChildRoute(
          '/apply-filters',
          child: (context, args) => ApplyFiltersScreen(filter: args.data),
        ),
      ];
}
