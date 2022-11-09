import 'package:e_markety_client/shared/utils/date_time_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../company/blocs/company/company_bloc.dart';
import 'information_container.dart';

class DeliveryTimeSettings extends StatefulWidget {
  const DeliveryTimeSettings({
    Key? key,
    required this.onTimeChanged,
  }) : super(key: key);

  final Function(DateTime?) onTimeChanged;

  @override
  State<DeliveryTimeSettings> createState() => _DeliveryTimeSettingsState();
}

class _DeliveryTimeSettingsState extends State<DeliveryTimeSettings> {
  @override
  void initState() {
    super.initState();
    Modular.get<CompanyBloc>().add(CompanyGetCurrentEvent());
  }

  void _onDeliveryTimeChanged(DateTime? value) => widget.onTimeChanged(value);

  List<DateTime> _buildItems(DateTime start, DateTime end) {
    var _start = start;
    if (_start.isAfter(end)) {
      return [];
    }

    final now = DateTime.now();
    if (_start.isBefore(now)) {
      _start = now;
    }

    final items = <DateTime>[];
    for (var i = _start.hour; i < end.hour; i++) {
      items.add(DateTime(now.year, now.month, now.day, i, start.minute));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return InformationContainer(
      title: 'Horário de Entrega',
      child: BlocBuilder<CompanyBloc, CompanyState>(
        bloc: Modular.get<CompanyBloc>(),
        builder: (context, state) {
          if (state is CompanyLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CompanyErrorState) {
            return Text(state.message);
          }

          if (state is CompanyLoadedCurrentState) {
            final company = state.company;

            return DropdownButtonFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide(color: Colors.grey.shade300, width: 2),
                ),
              ),
              items: _buildItems(
                DateTimeUtils.fromHourString(
                  company.deliveryOpeningTime ?? '00:00',
                ),
                DateTimeUtils.fromHourString(
                  company.deliveryClosingTime ?? '00:00',
                ),
              )
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text('${e.hour}:00 - ${e.hour + 1}:00'),
                    ),
                  )
                  .toList(),
              onChanged: _onDeliveryTimeChanged,
            );
          }

          return Container();
        },
      ),
    );
  }
}
