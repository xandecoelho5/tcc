enum SortType {
  popularity('Popularidade'),
  lowestFirst('Mais Barato'),
  highestFirst('Mais Caro'),
  discount('Desconto');

  const SortType(this.label);

  final String label;

  String toRemoteName() {
    switch (this) {
      case SortType.popularity:
        return 'POPULARIDADE';
      case SortType.lowestFirst:
        return 'MAIS_BARATO';
      case SortType.highestFirst:
        return 'MAIS_CARO';
      case SortType.discount:
        return 'DESCONTO';
    }
  }
}
