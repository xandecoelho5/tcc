import 'package:e_markety_client/features/home/screens/home_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../order/address/blocs/address/address_bloc.dart';
import '../order/address/blocs/default_address/default_address_bloc.dart';
import '../order/address/components/notifiers/district_notifier.dart';
import '../order/address/services/address_service.dart';
import '../order/address/services/district_service.dart';
import '../product/blocs/favourite/favourite_bloc.dart';
import '../product/services/favourite_service.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
        // favourite
        Bind.singleton<IFavouriteService>((i) => FavouriteService(i())),
        Bind.singleton((i) => FavouriteBloc(i())),
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
