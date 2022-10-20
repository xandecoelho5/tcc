import 'package:e_markety_client/core/services/snack_bar/snackbar_service.dart';
import 'package:e_markety_client/shared/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../blocs/order_bloc.dart';
import '../components/order_details.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.buildAppBar(context, title: 'Meus Pedidos'),
      body: BlocBuilder<OrderBloc, OrderState>(
        bloc: Modular.get<OrderBloc>()..add(OrderGetAllOrders()),
        builder: (context, state) {
          if (state is OrderLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is OrderLoaded) {
            if (state.orders.isEmpty) {
              return const Center(child: Text('Ainda não há pedidos'));
            }

            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              itemBuilder: (ctx, i) => OrderDetails(order: state.orders[i]),
              separatorBuilder: (ctx, i) => const SizedBox(height: 20),
              itemCount: state.orders.length,
            );
          }

          if (state is OrderError) {
            Modular.get<ISnackBarService>().showError(context, state.message);
          }

          return const Center(child: Text('Pedidos não carregados'));
        },
      ),
    );
  }
}
