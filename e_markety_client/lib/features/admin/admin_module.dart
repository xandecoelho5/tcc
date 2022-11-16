import 'package:e_markety_client/features/admin/district/admin_company_district_module.dart';
import 'package:e_markety_client/features/admin/home/notifiers/monthly_orders_notifier.dart';
import 'package:e_markety_client/features/admin/home/pages/dashboard_page.dart';
import 'package:e_markety_client/features/admin/home/pages/home_page.dart';
import 'package:e_markety_client/features/admin/home/services/report_service.dart';
import 'package:e_markety_client/features/admin/order/admin_order_module.dart';
import 'package:e_markety_client/features/admin/product/admin_product_module.dart';
import 'package:e_markety_client/features/admin/settings/admin_settings_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'home/notifiers/products_sales_notifier.dart';
import 'home/notifiers/status_summary_notifier.dart';

class AdminModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.singleton<IReportService>((i) => ReportService(i())),
        Bind.singleton((i) => StatusSummaryNotifier(i())),
        Bind.factory((i) => ProductsSalesNotifier(i())),
        Bind.singleton((i) => MonthlyOrdersNotifier(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (_, args) => const HomePage(),
          children: [
            ChildRoute('/dashboard', child: (_, __) => const DashboardPage()),
            ModuleRoute('/product', module: AdminProductModule()),
            ModuleRoute(
              '/company-district',
              module: AdminCompanyDistrictModule(),
            ),
            ModuleRoute('/order', module: AdminOrderModule()),
            ModuleRoute('/settings', module: AdminSettingsModule()),
          ],
        ),
      ];
}
