import 'package:e_markety_client/features/product/models/product.dart';

class ProductPageResponse {
  final List<Product> content;
  final int totalElements;
  final int totalPages;
  final int size;

  const ProductPageResponse({
    required this.content,
    required this.totalElements,
    required this.totalPages,
    required this.size,
  });

  const ProductPageResponse.empty({
    this.content = const [],
    this.totalElements = 0,
    this.totalPages = 0,
    this.size = 0,
  });

  factory ProductPageResponse.fromMap(dynamic map) {
    return ProductPageResponse(
      content: (map['content'] as List).map(Product.fromMap).toList(),
      totalElements: map['totalElements'],
      totalPages: map['totalPages'],
      size: map['size'],
    );
  }
}
