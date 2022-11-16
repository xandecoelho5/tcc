import 'package:e_markety_client/features/admin/home/components/charts/monthly_orders_chart.dart';
import 'package:e_markety_client/features/admin/home/components/charts/orders_overview_chart.dart';
import 'package:e_markety_client/features/admin/home/components/charts/products_sales_chart.dart';
import 'package:e_markety_client/features/admin/home/notifiers/monthly_orders_notifier.dart';
import 'package:e_markety_client/features/admin/home/notifiers/products_sales_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../user/auth/blocs/auth_bloc.dart';
import '../../shared/widgets/empty_container.dart';
import '../notifiers/status_summary_notifier.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      bloc: Modular.get<AuthBloc>(),
      builder: (context, state) {
        if (state is AuthLogged) {
          return const _Charts();
        }
        return const EmptyContainer(text: 'Carregando dados...');
      },
    );
  }
}

class _Charts extends StatefulWidget {
  const _Charts({Key? key}) : super(key: key);

  @override
  State<_Charts> createState() => _ChartsState();
}

class _ChartsState extends State<_Charts> {
  final _bestSellingProductsNotifier = Modular.get<ProductsSalesNotifier>();
  final _worstSellingProductsNotifier = Modular.get<ProductsSalesNotifier>();

  @override
  void initState() {
    super.initState();
    _bestSellingProductsNotifier.fetchData('DESC');
    _worstSellingProductsNotifier.fetchData('ASC');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              ValueListenableBuilder(
                valueListenable: _bestSellingProductsNotifier,
                builder: (context, value, child) {
                  if (value.isEmpty) {
                    return const EmptyContainer();
                  }
                  return Expanded(
                    child: ProductsSalesChart(
                      productsSales: value,
                      title: 'Mais Vendidos',
                    ),
                  );
                },
              ),
              ValueListenableBuilder(
                valueListenable: _worstSellingProductsNotifier,
                builder: (context, value, child) {
                  if (value.isEmpty) {
                    return const EmptyContainer();
                  }
                  return Expanded(
                    child: ProductsSalesChart(
                      productsSales: value,
                      title: 'Menos Vendidos',
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              ValueListenableBuilder(
                valueListenable: Modular.get<MonthlyOrdersNotifier>(),
                builder: (context, value, child) {
                  if (value.isEmpty) {
                    return const EmptyContainer();
                  }
                  return Expanded(
                    child: MonthlyOrdersChart(monthlyOrders: value),
                  );
                },
              ),
              ValueListenableBuilder(
                valueListenable: Modular.get<StatusSummaryNotifier>(),
                builder: (context, value, child) {
                  if (value.isEmpty) {
                    return const EmptyContainer();
                  }
                  return Expanded(
                    child: OrdersOverviewChart(statusSummary: value),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
