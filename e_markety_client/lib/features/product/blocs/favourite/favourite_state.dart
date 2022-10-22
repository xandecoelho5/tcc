part of 'favourite_bloc.dart';

enum FavouriteStatus { initial, loading, success, failure }

class FavouriteState extends Equatable {
  const FavouriteState({
    this.status = FavouriteStatus.initial,
    this.products = const [],
  });

  final FavouriteStatus status;
  final List<Product> products;

  FavouriteState copyWith({
    FavouriteStatus? status,
    List<Product>? products,
  }) {
    return FavouriteState(
      status: status ?? this.status,
      products: products ?? this.products,
    );
  }

  @override
  List<Object?> get props => [status, products];
}
