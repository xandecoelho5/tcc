import 'package:e_markety_client/features/admin/shared/data_responses/page_response.dart';

import '../../../company/models/company_district.dart';

class CompanyDistrictPageResponse extends PageResponse {
  const CompanyDistrictPageResponse({
    required super.content,
    required super.totalElements,
    required super.totalPages,
    required super.size,
  }) : super();

  CompanyDistrictPageResponse.empty() : super.empty();

  factory CompanyDistrictPageResponse.fromMap(dynamic map) {
    return CompanyDistrictPageResponse(
      content: (map['content'] as List).map(CompanyDistrict.fromMap).toList(),
      totalElements: map['totalElements'],
      totalPages: map['totalPages'],
      size: map['size'],
    );
  }

  @override
  String toString() {
    return 'CompanyDistrictPageResponse{content: $content, totalElements: $totalElements, totalPages: $totalPages, size: $size}';
  }
}
