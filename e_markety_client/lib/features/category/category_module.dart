import 'package:e_markety_client/features/category/screens/category_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CategoryModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const CategoryScreen()),
      ];
}
