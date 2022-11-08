import 'package:e_markety_client/features/user/components/avatar_container.dart';
import 'package:e_markety_client/features/user/components/icon_buttons_list.dart';
import 'package:e_markety_client/features/user/models/user.dart';
import 'package:e_markety_client/shared/theme/constants.dart';
import 'package:e_markety_client/shared/utils/bloc_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../shared/widgets/custom_app_bar.dart';
import '../auth/blocs/auth_bloc.dart';
import '../components/icon_button_container_big.dart';
import '../components/icon_button_model.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.buildAppBar(
        context,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BlocBuilder<AuthBloc, AuthState>(
              bloc: Modular.get<AuthBloc>(),
              builder: (context, state) {
                return Flexible(
                  flex: 5,
                  child: _Header(
                    user: state is AuthLogged ? state.user : const User.empty(),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            const Flexible(
              flex: 4,
              child: IconButtonsList(),
            ),
            const Flexible(
              flex: 2,
              child: IconButtonContainerBig(
                iconButton: IconButtonModel(
                  icon: Icons.logout,
                  label: 'Sair',
                  color: kSecondaryColor,
                  onTap: BlocUtils.signOut,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(height: MediaQuery.of(context).size.height * 0.29),
          Positioned(
            bottom: 0,
            height: 135,
            width: MediaQuery.of(context).size.width - 32,
            child: Container(
              decoration: BoxDecoration(
                color: kSecondaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: AvatarContainer(user: user),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.2,
            child: Column(
              children: [
                Text(
                  user.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  user.email,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
