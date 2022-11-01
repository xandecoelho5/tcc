import 'package:e_markety_client/features/admin/shared/data_responses/page_response.dart';
import 'package:e_markety_client/features/product/models/product.dart';

class ProductPageResponse extends PageResponse {
  const ProductPageResponse({
    required super.content,
    required super.totalElements,
    required super.totalPages,
    required super.size,
  }) : super();

  ProductPageResponse.empty() : super.empty();

  factory ProductPageResponse.fromMap(dynamic map) {
    return ProductPageResponse(
      content: (map['content'] as List).map(Product.fromMap).toList(),
      totalElements: map['totalElements'],
      totalPages: map['totalPages'],
      size: map['size'],
    );
  }

  @override
  String toString() {
    return 'ProductPageResponse{content: $content, totalElements: $totalElements, totalPages: $totalPages, size: $size}';
  }
}
