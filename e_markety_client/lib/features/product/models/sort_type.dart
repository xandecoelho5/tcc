enum SortType {
  bestSellers('Mais Vendidos'),
  lowestFirst('Mais Barato'),
  highestFirst('Mais Caro'),
  discount('Desconto');

  const SortType(this.label);

  final String label;

  String toRemoteName() {
    switch (this) {
      case SortType.bestSellers:
        return 'MAIS_VENDIDOS';
      case SortType.lowestFirst:
        return 'MAIS_BARATO';
      case SortType.highestFirst:
        return 'MAIS_CARO';
      case SortType.discount:
        return 'DESCONTO';
    }
  }
}
