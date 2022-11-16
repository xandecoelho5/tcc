import 'package:e_markety_client/features/admin/shared/widgets/custom_notifier.dart';
import 'package:e_markety_client/features/order/order/services/order_service.dart';

import '../../shared/data_responses/order_page_response.dart';
import '../../shared/data_responses/provider_settings.dart';

class OrderNotifier extends CustomNotifier {
  final IOrderService _service;
  bool _isStreamOpen = false;

  OrderNotifier(this._service)
      : super(
          _service,
          ProviderSettings(
            rowsPerPage: 10,
            sortColumnName: 'id',
            pageResponse: OrderPageResponse.empty(),
            sortAscending: false,
          ),
        );

  Future<void> updateOrderStatus(int id) async {
    final response = await _service.updateOrderStatus(id);
    response.fold(
      (l) => print(l.message),
      (r) => fetchData(), //value = value.copyWith(pageResponse: r)
    );
  }

  Future<void> streamData() async {
    _isStreamOpen = true;
    while (_isStreamOpen) {
      await Future.delayed(const Duration(seconds: 5));
      await fetchData();
    }
  }

  void closeStream() => _isStreamOpen = false;
}
