import 'package:e_markety_client/features/order/order/models/order_status.dart';
import 'package:e_markety_client/shared/utils/modular_utils.dart';
import 'package:e_markety_client/shared/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../blocs/order/order_bloc.dart';
import '../components/order_details.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.buildAppBar(context, title: 'Meus Pedidos'),
      body: BlocBuilder<OrderBloc, OrderState>(
        bloc: Modular.get<OrderBloc>()..add(OrderGetAllEvent()),
        builder: (context, state) {
          if (state is OrderLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is OrderLoaded) {
            final _orders = state.orders
                .where((o) => o.status != OrderStatus.pending)
                .toList();
            if (_orders.isEmpty) {
              return const Center(
                child: Text('Ainda não há pedidos realizados!'),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              itemBuilder: (ctx, i) => OrderDetails(order: _orders[i]),
              separatorBuilder: (ctx, i) => const SizedBox(height: 20),
              itemCount: _orders.length,
            );
          }

          if (state is OrderError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ModularUtils.showError(state.message);
            });
          }

          return const Center(child: Text('Pedidos não carregados'));
        },
      ),
    );
  }
}
