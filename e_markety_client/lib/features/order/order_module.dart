import 'package:e_markety_client/features/order/order/screens/my_order_details_screen.dart';
import 'package:e_markety_client/features/order/shopping_cart/screens/shopping_cart_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'address/screens/delivery_address_screen.dart';
import 'checkout/screens/checkout_screen.dart';
import 'order/screens/my_orders_screen.dart';
import 'order/screens/order_result_screen.dart';
import 'order/screens/track_order_screen.dart';

class OrderModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/shopping-cart',
          child: (context, args) => const ShoppingCartScreen(),
        ),
        ChildRoute(
          '/delivery-address',
          child: (context, args) => const DeliveryAddressScreen(),
        ),
        ChildRoute(
          '/checkout',
          child: (context, args) => CheckoutScreen(order: args.data),
        ),
        ChildRoute(
          '/order-result',
          child: (context, args) => OrderResultScreen(isSuccess: args.data),
        ),
        ChildRoute(
          '/track-order',
          child: (context, args) => const TrackOrderScreen(),
        ),
        ChildRoute(
          '/my-orders',
          child: (context, args) => const MyOrdersScreen(),
        ),
        ChildRoute(
          '/my-orders/details',
          child: (context, args) => MyOrderDetailsScreen(items: args.data),
        ),
      ];
}
