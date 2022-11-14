import 'package:e_markety_client/features/product/blocs/stock/stock_bloc.dart';
import 'package:e_markety_client/shared/utils/global.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/services/snack_bar/snackbar_service.dart';
import '../../features/order/shopping_cart/models/cart_item.dart';
import '../../features/user/auth/blocs/auth_bloc.dart';

class ModularUtils {
  ModularUtils._();

  static Future<void> signOut() async {
    Modular.get<AuthBloc>().add(AuthSignOutEvent());
    Modular.get<Global>().resetFilter();
    Future.delayed(const Duration(milliseconds: 10), () {
      Modular.to.navigate('/');
    });
  }

  static void showSnackbar(String message) {
    Modular.get<ISnackBarService>().show(message);
  }

  static void showError(String message) {
    Modular.get<ISnackBarService>().showError(message);
  }

  static void showSuccess(String message) {
    Modular.get<ISnackBarService>().showSuccess(message);
  }

  static void addToCart(CartItem cartItem) {
    Modular.get<StockBloc>().add(VerifyStock(cartItem));
  }
}
