import 'package:e_markety_client/features/admin/shared/widgets/custom_notifier.dart';

import '../../shared/data_responses/order_page_response.dart';
import '../../shared/data_responses/provider_settings.dart';
import '../../shared/services/paginated_service.dart';

class OrderNotifier extends CustomNotifier {
  OrderNotifier(IPaginatedService service)
      : super(
          service,
          ProviderSettings(
            rowsPerPage: 10,
            sortColumnName: 'id',
            pageResponse: OrderPageResponse.empty(),
            sortAscending: false,
          ),
        );
}
