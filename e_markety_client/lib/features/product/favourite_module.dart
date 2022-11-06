import 'package:e_markety_client/features/product/screens/favourite_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FavouriteModule extends Module {
  @override
  List<Bind<Object>> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const FavouriteScreen()),
      ];
}
