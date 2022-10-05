import 'package:e_markety_client/features/auth/screens/sign_in_screen.dart';
import 'package:e_markety_client/features/auth/screens/sign_up_screen.dart';
import 'package:e_markety_client/features/category/screens/category_screen.dart';
import 'package:e_markety_client/features/home/screens/home_screen.dart';
import 'package:e_markety_client/features/product/screens/product_details_screen.dart';
import 'package:e_markety_client/features/product/screens/products_by_category_screen.dart';
import 'package:e_markety_client/features/product/screens/search_result_screen.dart';
import 'package:e_markety_client/shared/widgets/custom_scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../shared/mocks/mocks.dart';
import '../shared/theme/theme.dart';
import 'auth/screens/welcome_screen.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (context, args) => const WelcomeScreen()),
    ChildRoute(
      '/sign-up',
      child: (context, args) => const SignUpScreen(),
    ),
    ChildRoute(
      '/sign-in',
      child: (context, args) => const SignInScreen(),
    ),
    ChildRoute(
      '/home',
      child: (context, args) => const HomeScreen(),
    ),
    ChildRoute(
      '/category',
      child: (context, args) => const CategoryScreen(),
    ),
    ChildRoute(
      '/search-result',
      child: (context, args) => const SearchResultScreen(),
    ),
    ChildRoute(
      '/products-by-category',
      child: (context, args) => ProductsByCategoryScreen(
        category: categoriesMock[0],
        products: productsMock,
      ),
    ),
    ChildRoute(
      '/product-details',
      child: (context, args) => ProductDetailsScreen(product: productsMock[0]),
    ),
  ];
}

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'EMarkety',
      theme: kThemeData,
      routerDelegate: Modular.routerDelegate,
      routeInformationParser: Modular.routeInformationParser,
      debugShowCheckedModeBanner: false,
      scrollBehavior: CustomScrollBehavior(),
    );
  }
}
