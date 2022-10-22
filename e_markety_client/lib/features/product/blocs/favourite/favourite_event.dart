part of 'favourite_bloc.dart';

abstract class FavouriteEvent extends Equatable {
  const FavouriteEvent();

  @override
  List<Object> get props => [];
}

class FavouriteSubscriptionRequested extends FavouriteEvent {
  const FavouriteSubscriptionRequested();
}

class FavouriteAdd extends FavouriteEvent {
  const FavouriteAdd(this.product);

  final Product product;

  @override
  List<Object> get props => [product];
}

class FavouriteRemove extends FavouriteEvent {
  const FavouriteRemove(this.productId);

  final int productId;

  @override
  List<Object> get props => [productId];
}
