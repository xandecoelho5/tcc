extension StringExtension on String? {
  bool get isNotBlank => this != null && this!.trim().isNotEmpty;

  bool get isBlank => this == null || this!.trim().isEmpty;
}
