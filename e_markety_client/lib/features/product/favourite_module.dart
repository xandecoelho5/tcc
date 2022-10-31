import 'package:e_markety_client/features/product/screens/favourite_screen.dart';
import 'package:e_markety_client/features/product/services/favourite_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'blocs/favourite/favourite_bloc.dart';

class FavouriteModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.singleton<IFavouriteService>((i) => FavouriteService(i())),
        Bind.singleton((i) => FavouriteBloc(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const FavouriteScreen()),
      ];
}
