import 'package:e_markety_client/features/admin/settings/pages/company_settings_page.dart';
import 'package:e_markety_client/features/company/blocs/company/company_bloc.dart';
import 'package:e_markety_client/features/company/services/company_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../order/address/blocs/address/address_bloc.dart';
import '../../order/address/screens/edit_address_screen.dart';
import '../../order/address/services/address_service.dart';
import '../../order/address/services/district_service.dart';
import '../district/notifiers/district_notifier.dart';

class AdminSettingsModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton<IDistrictService>((i) => DistrictService(i())),
    Bind.lazySingleton((i) => DistrictNotifier(i())),
    Bind.lazySingleton<ICompanyService>((i) => CompanyService(i())),
    Bind.lazySingleton((i) => CompanyBloc(i())),
    Bind.lazySingleton<IAddressService>((i) => AddressService(i())),
    Bind.lazySingleton((i) => AddressBloc(i())),
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
