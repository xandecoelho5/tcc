import 'package:e_markety_client/features/home/screens/home_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../shared/utils/global.dart';
import '../category/blocs/category_bloc.dart';
import '../category/services/category_service.dart';
import '../order/address/blocs/address/address_bloc.dart';
import '../order/address/blocs/default_address/default_address_bloc.dart';
import '../order/address/components/notifiers/district_notifier.dart';
import '../order/address/services/address_service.dart';
import '../order/address/services/district_service.dart';
import '../product/blocs/favourite/favourite_bloc.dart';
import '../product/blocs/filter/filter_bloc.dart';
import '../product/blocs/product/product_bloc.dart';
import '../product/blocs/product_by_category/product_by_category_bloc.dart';
import '../product/services/favourite_service.dart';
import '../product/services/product_service.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
        // category
        Bind.singleton<ICategoryService>((i) => CategoryService(i())),
        Bind.singleton((i) => CategoryBloc(i())),
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
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const HomeScreen()),
      ];
}
