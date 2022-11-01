import 'package:e_markety_client/features/admin/order/pages/orders_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AdminOrderModule extends Module {
  @override
  List<Bind<Object>> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const OrdersPage()),
      ];
}
