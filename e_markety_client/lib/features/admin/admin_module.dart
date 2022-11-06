import 'package:e_markety_client/features/admin/home/pages/dashboard_page.dart';
import 'package:e_markety_client/features/admin/home/pages/home_page.dart';
import 'package:e_markety_client/features/admin/order/admin_order_module.dart';
import 'package:e_markety_client/features/admin/product/admin_product_module.dart';
import 'package:e_markety_client/features/admin/settings/admin_settings_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AdminModule extends Module {
  @override
  List<Bind<Object>> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (_, args) => const HomePage(),
          children: [
            ChildRoute('/dashboard', child: (_, __) => const DashboardPage()),
            ModuleRoute('/product', module: AdminProductModule()),
            ModuleRoute('/order', module: AdminOrderModule()),
            ModuleRoute('/settings', module: AdminSettingsModule()),
          ],
        ),
      ];
}

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Página não encontrada'),
      ),
    );
  }
}
