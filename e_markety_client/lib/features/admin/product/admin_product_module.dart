import 'package:e_markety_client/features/admin/product/components/notifiers/category_notifier.dart';
import 'package:e_markety_client/features/admin/product/components/notifiers/measure_unit_notifier.dart';
import 'package:e_markety_client/features/admin/product/components/notifiers/product_notifier.dart';
import 'package:e_markety_client/features/admin/product/screens/product_add_screen.dart';
import 'package:e_markety_client/features/admin/product/screens/product_edit_screen.dart';
import 'package:e_markety_client/features/admin/product/screens/products_list_screen.dart';
import 'package:e_markety_client/features/admin/product/services/measure_unit_service.dart';
import 'package:e_markety_client/features/category/services/category_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../product/blocs/product/product_bloc.dart';
import '../../product/services/product_service.dart';
import 'blocs/admin_product_bloc.dart';

class AdminProductModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.lazySingleton<IProductService>((i) => ProductService(i())),
        Bind.lazySingleton((i) => ProductBloc(i())),
        Bind.lazySingleton((i) => ProductNotifier(i())),
        Bind.lazySingleton((i) => AdminProductBloc(i())),
        Bind.lazySingleton<ICategoryService>((i) => CategoryService(i())),
        Bind.lazySingleton((i) => CategoryNotifier(i())),
        Bind.lazySingleton<IMeasureUnitService>((i) => MeasureUnitService(i())),
        Bind.lazySingleton((i) => MeasureUnitNotifier(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const ProductsListScreen()),
        ChildRoute(
          '/add',
          child: (context, args) => const ProductAddScreen(),
        ),
        ChildRoute(
          '/edit/:id',
          child: (context, args) => ProductEditScreen(id: args.params['id']),
        ),
      ];
}
