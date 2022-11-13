import 'package:e_markety_client/features/admin/district/components/company_district_notifier.dart';
import 'package:e_markety_client/features/admin/district/pages/company_district_add_page.dart';
import 'package:e_markety_client/features/admin/district/pages/company_district_edit_page.dart';
import 'package:e_markety_client/features/admin/district/pages/company_districts_list_page.dart';
import 'package:e_markety_client/features/order/address/services/district_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../company/blocs/company_district/company_district_bloc.dart';
import '../../company/services/company_district_service.dart';
import '../shared/widgets/custom_notifier.dart';
import 'components/district_notifier.dart';

class AdminCompanyDistrictModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton<IDistrictService>((i) => DistrictService(i())),
    Bind.factory((i) => DistrictNotifier(i())),
    Bind.lazySingleton<ICompanyDistrictService>(
      (i) => CompanyDistrictService(i()),
    ),
    Bind.lazySingleton((i) => CompanyDistrictBloc(i())),
    Bind.lazySingleton<CustomNotifier>((i) => CompanyDistrictNotifier(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (context, args) => const CompanyDistrictsListPage(),
    ),
    ChildRoute(
      '/add',
      child: (context, args) => const CompanyDistrictAddPage(),
    ),
    ChildRoute(
      '/edit/:id',
      child: (context, args) => CompanyDistrictEditPage(id: args.params['id']),
    ),
  ];
}
