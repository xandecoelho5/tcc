import 'package:e_markety_client/features/admin/district/notifiers/district_notifier.dart';
import 'package:e_markety_client/features/home/screens/home_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../shared/utils/global.dart';
import '../category/blocs/category_bloc.dart';
import '../category/services/category_service.dart';
import '../order/address/blocs/address/address_bloc.dart';
import '../order/address/blocs/default_address/default_address_bloc.dart';
import '../order/address/components/company_district_value_notifier.dart';
import '../order/address/services/address_service.dart';
import '../order/address/services/district_service.dart';
import '../order/order/blocs/current_order/current_order_bloc.dart';
import '../order/order/blocs/order/order_bloc.dart';
import '../order/order/services/current_order_service.dart';
import '../order/order/services/order_service.dart';
import '../order/shopping_cart/blocs/overview/cart_item_overview_bloc.dart';
import '../order/shopping_cart/services/cart_item_service.dart';
import '../product/blocs/favourite/favourite_bloc.dart';
import '../product/blocs/filter/filter_bloc.dart';
import '../product/blocs/product/product_bloc.dart';
import '../product/blocs/product_by_category/product_by_category_bloc.dart';
import '../product/blocs/product_price/product_price_bloc.dart';
import '../product/blocs/stock/stock_bloc.dart';
import '../product/services/favourite_service.dart';
import '../product/services/product_service.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
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
        // category
        Bind.singleton<ICategoryService>((i) => CategoryService(i())),
        Bind.singleton((i) => CategoryBloc(i())),
        // product
        Bind.singleton<IProductService>((i) => ProductService(i())),
        Bind.factory((i) => ProductBloc(i())),
        Bind.singleton((i) => ProductByCategoryBloc(i())),
        Bind.singleton((i) => ProductPriceBloc(i())),
        Bind.singleton((i) => StockBloc(i())),
        // filter
        Bind.singleton((i) => FilterBloc(i())),
        Bind.singleton((i) => Global()),
        // favourite
        Bind.singleton<IFavouriteService>((i) => FavouriteService(i())),
        Bind.singleton((i) => FavouriteBloc(i())),
        // address
        Bind.singleton<IAddressService>((i) => AddressService(i())),
        Bind.lazySingleton<IDistrictService>((i) => DistrictService(i())),
        Bind.singleton((i) => AddressBloc(i())),
        Bind.singleton((i) => DefaultAddressBloc(i())),
        Bind.lazySingleton((i) => CompanyDistrictValueNotifier(i())),
        Bind.lazySingleton((i) => DistrictNotifier(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const HomeScreen()),
      ];
}
