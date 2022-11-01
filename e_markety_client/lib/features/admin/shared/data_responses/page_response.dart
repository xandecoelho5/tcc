abstract class PageResponse {
  final List<dynamic> content;
  final int totalElements;
  final int totalPages;
  final int size;

  const PageResponse({
    required this.content,
    required this.totalElements,
    required this.totalPages,
    required this.size,
  });

  const PageResponse.empty({
    this.content = const [],
    this.totalElements = 0,
    this.totalPages = 0,
    this.size = 0,
  });
}
