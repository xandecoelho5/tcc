enum SortType {
  popularity('Popularity'),
  lowestFirst('Lowest First'),
  highestFirst('Highest First'),
  discount('Discount');

  const SortType(this.label);

  final String label;
}
