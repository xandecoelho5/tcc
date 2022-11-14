import 'package:e_markety_client/features/admin/home/services/status_summary_notifier.dart';
import 'package:e_markety_client/features/admin/order/components/orders_overview_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../user/auth/blocs/auth_bloc.dart';
import '../../shared/widgets/empty_container.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      bloc: Modular.get<AuthBloc>(),
      builder: (context, state) {
        if (state is AuthLogged) {
          return ValueListenableBuilder(
            valueListenable: Modular.get<StatusSummaryNotifier>(),
            builder: (context, value, child) {
              if (value.isEmpty) {
                return const EmptyContainer();
              }
              return OrdersOverviewChart(statusSummary: value);
            },
          );
        }
        return const EmptyContainer(text: 'Carregando dados...');
      },
    );
  }
}
