import 'package:e_markety_client/core/services/http/http_service.dart';
import 'package:e_markety_client/features/product/exceptions/favourite_exception.dart';
import 'package:e_markety_client/features/product/models/product.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

import '../../user/auth/blocs/auth_bloc.dart';

abstract class IFavouriteService {
  Future<void> addToFavourite(Product product);

  Future<void> removeFromFavourite(int id);

  Stream<List<Product>> getFavourites();
}

class FavouriteService implements IFavouriteService {
  final IHttpService _httpService;
  final _streamController = BehaviorSubject<List<Product>>.seeded(const []);

  FavouriteService(this._httpService) {
    _init();
  }

  Future<void> _init() async {
    final response = await _httpService.getAll('/usuario/favoritos');
    try {
      response.fold(
        (error) => throw FavouriteException(error.message),
        (data) {
          final products = data.map(Product.fromMap).toList();
          _streamController.add(products);
        },
      );
    } catch (e) {
      print('xd $e');
    }
  }

  @override
  Stream<List<Product>> getFavourites() =>
      _streamController.asBroadcastStream();

  @override
  Future<void> addToFavourite(Product product) async {
    final favourites = [..._streamController.value];
    final index = favourites.indexWhere((t) => t.id == product.id);
    if (index < 0) {
      favourites.add(product);
      _streamController.add(favourites);
      await _httpService.patch('/usuario/favoritos', {'id': product.id});
      Modular.get<AuthBloc>().add(AuthGetCurrentUserEvent());
    }
  }

  @override
  Future<void> removeFromFavourite(int id) async {
    final favourites = [..._streamController.value];
    final index = favourites.indexWhere((t) => t.id == id);
    if (index >= 0) {
      favourites.removeAt(index);
      _streamController.add(favourites);
      await _httpService.patch('/usuario/favoritos', {'id': id});
      Modular.get<AuthBloc>().add(AuthGetCurrentUserEvent());
    }
  }
}
