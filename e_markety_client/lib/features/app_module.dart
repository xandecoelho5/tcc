import 'package:asuka/asuka.dart';
import 'package:e_markety_client/core/core_module.dart';
import 'package:e_markety_client/features/admin/admin_module.dart';
import 'package:e_markety_client/features/category/category_module.dart';
import 'package:e_markety_client/features/company/services/company_service.dart';
import 'package:e_markety_client/features/home/home_module.dart';
import 'package:e_markety_client/features/order/address/address_module.dart';
import 'package:e_markety_client/features/order/order_module.dart';
import 'package:e_markety_client/features/product/favourite_module.dart';
import 'package:e_markety_client/features/product/product_module.dart';
import 'package:e_markety_client/features/user/auth/blocs/auth_bloc.dart';
import 'package:e_markety_client/features/user/auth/screens/sign_in_screen.dart';
import 'package:e_markety_client/features/user/auth/screens/welcome_screen.dart';
import 'package:e_markety_client/features/user/auth/services/auth_service.dart';
import 'package:e_markety_client/features/user/blocs/user_bloc.dart';
import 'package:e_markety_client/features/user/screens/sign_up_screen.dart';
import 'package:e_markety_client/features/user/services/user_service.dart';
import 'package:e_markety_client/features/user/user_module.dart';
import 'package:e_markety_client/shared/widgets/custom_scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../shared/theme/theme.dart';
import 'company/blocs/company/company_bloc.dart';
import 'company/blocs/company_district/company_district_bloc.dart';
import 'company/services/company_district_service.dart';
import 'order/order/blocs/current_order/current_order_bloc.dart';
import 'order/order/blocs/order/order_bloc.dart';
import 'order/order/services/current_order_service.dart';
import 'order/order/services/order_service.dart';
import 'order/shopping_cart/blocs/overview/cart_item_overview_bloc.dart';
import 'order/shopping_cart/services/cart_item_service.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
      ];

  @override
  final List<Bind> binds = [
    // user
    Bind.singleton<IUserService>((i) => UserService(i())),
    Bind.singleton((i) => UserBloc(i())),
    // auth
    Bind.singleton<IAuthService>((i) => AuthService(i(), i())),
    Bind.singleton((i) => AuthBloc(i(), i())),
    // company
    Bind.singleton<ICompanyService>((i) => CompanyService(i())),
    Bind.singleton((i) => CompanyBloc(i())),
    Bind.lazySingleton<ICompanyDistrictService>(
      (i) => CompanyDistrictService(i()),
    ),
    Bind.singleton((i) => CompanyDistrictBloc(i())),
    // cart item
    Bind.singleton<ICartItemService>((i) => CartItemService(i(), i(), i())),
    Bind.singleton((i) => CartItemOverviewBloc(i())),
    // order
    Bind.singleton<IOrderService>((i) => OrderService(i())),
    Bind.singleton<ICurrentOrderService>(
      (i) => CurrentOrderService(i(), i()),
    ),
    Bind.singleton((i) => OrderBloc(i(), i())),
    Bind.singleton((i) => CurrentOrderBloc(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (context, args) => const WelcomeScreen()),
    ChildRoute('/sign-up', child: (context, args) => const SignUpScreen()),
    ChildRoute('/sign-in', child: (context, args) => const SignInScreen()),
    ModuleRoute('/home', module: HomeModule()),
    ModuleRoute('/user', module: UserModule()),
    ModuleRoute('/favourite', module: FavouriteModule()),
    ModuleRoute('/category', module: CategoryModule()),
    ModuleRoute('/product', module: ProductModule()),
    ModuleRoute('/address', module: AddressModule()),
    ModuleRoute('/order', module: OrderModule()),
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
