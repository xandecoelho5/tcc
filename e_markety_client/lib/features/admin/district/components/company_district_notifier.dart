import 'package:e_markety_client/features/admin/shared/data_responses/company_district_page_response.dart';
import 'package:e_markety_client/features/admin/shared/widgets/custom_notifier.dart';

import '../../shared/data_responses/provider_settings.dart';
import '../../shared/services/paginated_service.dart';

class CompanyDistrictNotifier extends CustomNotifier {
  CompanyDistrictNotifier(IPaginatedService service)
      : super(
          service,
          ProviderSettings(
            rowsPerPage: 10,
            sortColumnName: 'bairro_nome',
            pageResponse: CompanyDistrictPageResponse.empty(),
          ),
        );
}
