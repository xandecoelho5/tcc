import 'package:e_markety_client/features/product/models/product.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/favourite_service.dart';

part 'favourite_event.dart';
part 'favourite_state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  final IFavouriteService _favouriteService;

  FavouriteBloc(this._favouriteService) : super(const FavouriteState()) {
    on<FavouriteSubscriptionRequested>(_onSubscriptionRequested);
    on<FavouriteAdd>(_onAdd);
    on<FavouriteRemove>(_onRemove);
  }

  Future<void> _onSubscriptionRequested(event, Emitter emit) async {
    emit(state.copyWith(status: FavouriteStatus.loading));

    await emit.forEach<List<Product>>(
      _favouriteService.getFavourites(),
      onData: (favourites) => state.copyWith(
        status: FavouriteStatus.success,
        products: favourites,
      ),
      onError: (_, __) => state.copyWith(status: FavouriteStatus.failure),
    );
  }

  Future<void> _onAdd(FavouriteAdd event, emit) async {
    await _favouriteService.addToFavourite(event.product);
  }

  Future<void> _onRemove(FavouriteRemove event, emit) async {
    await _favouriteService.removeFromFavourite(event.productId);
  }
}
