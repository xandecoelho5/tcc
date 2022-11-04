import 'package:e_markety_client/features/admin/settings/pages/company_settings_page.dart';
import 'package:e_markety_client/features/company/blocs/company_bloc.dart';
import 'package:e_markety_client/features/company/services/company_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../order/address/screens/edit_address_screen.dart';

class AdminSettingsModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton<ICompanyService>((i) => CompanyService(i())),
    Bind.lazySingleton((i) => CompanyBloc(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const CompanySettingsPage()),
    ChildRoute(
      '/address/edit/:id',
      child: (_, args) => EditAddressScreen(id: args.params['id']),
    ),
  ];
}
