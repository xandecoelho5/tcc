import 'package:asuka/asuka.dart';
import 'package:e_markety_client/core/core_module.dart';
import 'package:e_markety_client/features/admin/admin_module.dart';
import 'package:e_markety_client/features/category/blocs/category_bloc.dart';
import 'package:e_markety_client/features/category/screens/category_screen.dart';
import 'package:e_markety_client/features/category/services/category_service.dart';
import 'package:e_markety_client/features/company/services/company_service.dart';
import 'package:e_markety_client/features/home/screens/home_screen.dart';
import 'package:e_markety_client/features/order/address/address_module.dart';
import 'package:e_markety_client/features/order/address/blocs/default_address/default_address_bloc.dart';
import 'package:e_markety_client/features/order/address/components/notifiers/district_notifier.dart';
import 'package:e_markety_client/features/order/address/services/address_service.dart';
import 'package:e_markety_client/features/order/address/services/district_service.dart';
import 'package:e_markety_client/features/order/checkout/screens/checkout_screen.dart';
import 'package:e_markety_client/features/order/order/blocs/current_order/current_order_bloc.dart';
import 'package:e_markety_client/features/order/order/services/current_order_service.dart';
import 'package:e_markety_client/features/order/shopping_cart/blocs/overview/cart_item_overview_bloc.dart';
import 'package:e_markety_client/features/order/shopping_cart/repositories/cart_item_repository.dart';
import 'package:e_markety_client/features/product/blocs/favourite/favourite_bloc.dart';
import 'package:e_markety_client/features/product/blocs/filter/filter_bloc.dart';
import 'package:e_markety_client/features/product/blocs/product/product_bloc.dart';
import 'package:e_markety_client/features/product/blocs/product_by_category/product_by_category_bloc.dart';
import 'package:e_markety_client/features/product/favourite_module.dart';
import 'package:e_markety_client/features/product/screens/apply_filters_screen.dart';
import 'package:e_markety_client/features/product/screens/product_details_screen.dart';
import 'package:e_markety_client/features/product/screens/products_by_category_screen.dart';
import 'package:e_markety_client/features/product/screens/search_result_screen.dart';
import 'package:e_markety_client/features/product/services/favourite_service.dart';
import 'package:e_markety_client/features/product/services/product_service.dart';
import 'package:e_markety_client/features/user/auth/blocs/auth_bloc.dart';
import 'package:e_markety_client/features/user/auth/screens/sign_in_screen.dart';
import 'package:e_markety_client/features/user/auth/screens/welcome_screen.dart';
import 'package:e_markety_client/features/user/auth/services/auth_service.dart';
import 'package:e_markety_client/features/user/blocs/user_bloc.dart';
import 'package:e_markety_client/features/user/screens/about_me_screen.dart';
import 'package:e_markety_client/features/user/screens/sign_up_screen.dart';
import 'package:e_markety_client/features/user/screens/user_profile_screen.dart';
import 'package:e_markety_client/features/user/services/user_service.dart';
import 'package:e_markety_client/shared/utils/global.dart';
import 'package:e_markety_client/shared/widgets/custom_scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../shared/theme/theme.dart';
import 'company/blocs/company_bloc.dart';
import 'order/address/blocs/address/address_bloc.dart';
import 'order/address/screens/delivery_address_screen.dart';
import 'order/order/blocs/order/order_bloc.dart';
import 'order/order/screens/my_orders_screen.dart';
import 'order/order/screens/order_result_screen.dart';
import 'order/order/screens/track_order_screen.dart';
import 'order/order/services/order_service.dart';
import 'order/shopping_cart/screens/shopping_cart_screen.dart';
import 'order/shopping_cart/services/cart_item_service.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
      ];

  @override
  final List<Bind> binds = [
    // category
    Bind.singleton<ICategoryService>((i) => CategoryService(i())),
    Bind.singleton((i) => CategoryBloc(i())),
    // user
    Bind.singleton<IUserService>((i) => UserService(i())),
    Bind.singleton((i) => UserBloc(i())),
    // auth
    Bind.singleton<IAuthService>((i) => AuthService(i(), i())),
    Bind.singleton((i) => AuthBloc(i(), i())),
    // company
    Bind.singleton<ICompanyService>((i) => CompanyService(i())),
    Bind.singleton((i) => CompanyBloc(i())),
    // product
    Bind.singleton<IProductService>((i) => ProductService(i())),
    Bind.singleton((i) => ProductBloc(i())),
    Bind.singleton((i) => ProductByCategoryBloc(i())),
    // favourite
    Bind.singleton<IFavouriteService>((i) => FavouriteService(i())),
    Bind.singleton((i) => FavouriteBloc(i())),
    // filter
    Bind.singleton((i) => FilterBloc(i())),
    Bind.singleton((i) => Global()),
    // address
    Bind.singleton<IAddressService>((i) => AddressService(i())),
    Bind.lazySingleton<IDistrictService>((i) => DistrictService(i())),
    Bind.singleton((i) => AddressBloc(i())),
    Bind.singleton((i) => DefaultAddressBloc(i())),
    Bind.lazySingleton((i) => DistrictNotifier(i())),
    // cart item
    Bind.singleton<ICartItemService>((i) => CartItemService(i())),
    Bind.singleton((i) => CartItemRepository(i())),
    Bind.singleton((i) => CartItemOverviewBloc(i())),
    // order
    Bind.singleton<IOrderService>((i) => OrderService(i())),
    Bind.singleton<ICurrentOrderService>((i) => CurrentOrderService(i(), i())),
    Bind.singleton((i) => OrderBloc(i(), i(), i())),
    Bind.singleton((i) => CurrentOrderBloc(i())),
  ];

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
      child: (context, args) => ProductsByCategoryScreen(category: args.data),
    ),
    ChildRoute(
      '/product-details',
      child: (context, args) => ProductDetailsScreen(product: args.data),
    ),
    ChildRoute(
      '/shopping-cart',
      child: (context, args) => const ShoppingCartScreen(),
    ),
    ChildRoute(
      '/delivery-address',
      child: (context, args) => const DeliveryAddressScreen(),
    ),
    ChildRoute(
      '/checkout',
      child: (context, args) => CheckoutScreen(order: args.data),
    ),
    ChildRoute(
      '/order-result',
      child: (context, args) => OrderResultScreen(isSuccess: args.data),
    ),
    ChildRoute(
      '/track-order',
      child: (context, args) => const TrackOrderScreen(),
    ),
    ChildRoute(
      '/apply-filters',
      child: (context, args) => ApplyFiltersScreen(filter: args.data),
    ),
    ChildRoute(
      '/user-profile',
      child: (context, args) => const UserProfileScreen(),
    ),
    ChildRoute('/about-me', child: (context, args) => const AboutMeScreen()),
    ChildRoute('/my-orders', child: (context, args) => const MyOrdersScreen()),
    // modules
    ModuleRoute('/favourite', module: FavouriteModule()),
    ModuleRoute('/address', module: AddressModule()),
    ModuleRoute(
      '/admin',
      module: AdminModule(),
      transition: TransitionType.scale,
    ),
  ];
}

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      builder: Asuka.builder,
      title: 'EMarkety',
      theme: kThemeData,
      routerDelegate: Modular.routerDelegate,
      routeInformationParser: Modular.routeInformationParser,
      debugShowCheckedModeBanner: false,
      scrollBehavior: CustomScrollBehavior(),
    );
  }
}
