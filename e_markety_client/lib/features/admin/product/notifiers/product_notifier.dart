import 'package:e_markety_client/features/admin/shared/data_responses/provider_settings.dart';
import 'package:e_markety_client/features/admin/shared/services/paginated_service.dart';
import 'package:e_markety_client/features/admin/shared/widgets/custom_notifier.dart';

import '../../shared/data_responses/product_page_response.dart';

class ProductNotifier extends CustomNotifier {
  ProductNotifier(IPaginatedService service)
      : super(
          service,
          ProviderSettings(
            rowsPerPage: 10,
            sortColumnName: 'nome',
            pageResponse: ProductPageResponse.empty(),
          ),
        );
}
