import 'package:e_markety_client/features/order/order/blocs/current_order/current_order_bloc.dart';
import 'package:e_markety_client/features/order/order/components/track_order_summary.dart';
import 'package:e_markety_client/features/order/order/models/order_status.dart';
import 'package:e_markety_client/shared/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../components/order_timeline.dart';
import '../models/delivery_tipe.dart';
import '../models/order.dart';

class TrackOrderScreen extends StatelessWidget {
  const TrackOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.buildAppBar(
        context,
        title: 'Rastrear pedido',
        showAction: false,
        onLeadingTap: () {
          final routes = Modular.to.navigateHistory;
          routes[routes.length - 2].name == '/my-orders'
              ? Modular.to.pop()
              : Modular.to.pushNamedAndRemoveUntil('/', (_) => false);
        },
      ),
      body: BlocBuilder<CurrentOrderBloc, CurrentOrderState>(
        bloc: Modular.get<CurrentOrderBloc>()..add(GetCurrentOrder()),
        builder: (context, state) {
          if (state is CurrentOrderError) {
            return Center(child: Text(state.message));
          }

          if (state is CurrentOrderLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CurrentOrderLoaded) {
            return _TrackOrderView(order: state.order);
          }

          return Container();
        },
      ),
    );
  }
}

class _TrackOrderView extends StatelessWidget {
  const _TrackOrderView({Key? key, required this.order}) : super(key: key);

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TrackOrderSummary(order: order),
          const SizedBox(height: 16),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: OrderTimeline(
                process: order.status,
                processes: order.deliveryType == DeliveryType.delivery
                    ? OrderStatus.caseDelivery()
                    : OrderStatus.casePickup(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
