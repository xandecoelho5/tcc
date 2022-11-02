import 'package:e_markety_client/features/admin/shared/data_responses/page_response.dart';

import '../../order/models/order_admin.dart';

class OrderPageResponse extends PageResponse {
  const OrderPageResponse({
    required super.content,
    required super.totalElements,
    required super.totalPages,
    required super.size,
  }) : super();

  OrderPageResponse.empty() : super.empty();

  factory OrderPageResponse.fromMap(dynamic map) {
    return OrderPageResponse(
      content: (map['content'] as List).map(OrderAdmin.fromMap).toList(),
      totalElements: map['totalElements'],
      totalPages: map['totalPages'],
      size: map['size'],
    );
  }

  @override
  String toString() {
    return 'OrderPageResponse{content: $content, totalElements: $totalElements, totalPages: $totalPages, size: $size}';
  }
}
