import 'package:e_markety_client/features/order/address/screens/add_new_address_screen.dart';
import 'package:e_markety_client/features/order/address/screens/address_screen.dart';
import 'package:e_markety_client/features/order/address/screens/edit_address_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AddressModule extends Module {
  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (context, args) => AddressScreen()),
    ChildRoute(
      '/add',
      child: (context, args) => AddNewAddressScreen(getDefault: args.data),
    ),
    ChildRoute(
      '/edit/:id',
      child: (context, args) => EditAddressScreen(id: args.params['id']),
    ),
  ];
}
