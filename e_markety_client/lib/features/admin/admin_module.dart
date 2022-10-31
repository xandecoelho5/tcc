import 'package:dio/dio.dart';
import 'package:e_markety_client/features/admin/home/screens/home_screen.dart';
import 'package:e_markety_client/features/admin/product/admin_product_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AdminModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.singleton((i) => Dio()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const HomeScreen(),
          children: [
            ModuleRoute('/product', module: AdminProductModule()),
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
