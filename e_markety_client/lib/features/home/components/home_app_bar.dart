import 'package:e_markety_client/features/order/address/blocs/default_address/default_address_bloc.dart';
import 'package:e_markety_client/features/user/auth/blocs/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../shared/theme/constants.dart';
import '../../../shared/widgets/action_cart.dart';
import '../../user/models/user.dart';

class HomeAppBar {
  const HomeAppBar._();

  static AppBar build(BuildContext context) {
    Padding _titleRow(User user) {
      return Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Row(
          children: [
            Material(
              elevation: 1,
              borderRadius: BorderRadius.circular(50),
              child: InkWell(
                onTap: () =>
                    Modular.to.pushNamed('/user-profile', arguments: user),
                borderRadius: BorderRadius.circular(50),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 21,
                  child: CircleAvatar(
                    radius: 17,
                    backgroundImage: NetworkImage(user.avatarUrl),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Olá, ${user.name}',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: kBasicDarkColor,
                  ),
                ),
                BlocBuilder<DefaultAddressBloc, DefaultAddressState>(
                  bloc: Modular.get<DefaultAddressBloc>(),
                  builder: (context, state) {
                    if (state is DefaultAddressLoaded) {
                      return Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: kPrimaryColor,
                            size: 12,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            state.address.street,
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      );
                    }
                    if (state is DefaultAddressError) {
                      return Text(
                        state.message,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ],
        ),
      );
    }

    return AppBar(
      automaticallyImplyLeading: false,
      title: BlocBuilder<AuthBloc, AuthState>(
        bloc: Modular.get<AuthBloc>(),
        builder: (context, state) {
          if (state is AuthLogged) {
            return _titleRow(state.user);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      actions: const [ActionCart()],
    );
  }
}
