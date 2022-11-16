import 'package:e_markety_client/features/admin/order/notifiers/order_notifier.dart';
import 'package:e_markety_client/features/admin/order/pages/orders_page.dart';
import 'package:e_markety_client/features/order/order/services/order_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../shared/widgets/custom_notifier.dart';

class AdminOrderModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.lazySingleton<IOrderService>((i) => OrderService(i())),
        Bind.lazySingleton<CustomNotifier>((i) => OrderNotifier(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const OrdersPage()),
      ];
}
