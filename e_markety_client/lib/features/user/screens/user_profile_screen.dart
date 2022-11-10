import 'package:e_markety_client/features/user/components/icon_buttons_list.dart';
import 'package:e_markety_client/features/user/models/user.dart';
import 'package:e_markety_client/shared/theme/constants.dart';
import 'package:e_markety_client/shared/utils/modular_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../shared/widgets/custom_app_bar.dart';
import '../auth/blocs/auth_bloc.dart';
import '../blocs/user_bloc.dart';
import '../components/avatar_container.dart';
import '../components/icon_button_container_big.dart';
import '../components/icon_button_model.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      bloc: Modular.get<UserBloc>(),
      listener: (context, state) {
        if (state is UserUpdated) {
          ModularUtils.showSuccess('Perfil atualizado com sucesso!');
        }
        if (state is UserPasswordUpdated) {
          ModularUtils.showSuccess('Senha atualizada com sucesso!');
        }
        if (state is UserError) {
          ModularUtils.showError(state.message);
        }
      },
      child: Scaffold(
        appBar: CustomAppBar.buildAppBar(
          context,
          backgroundColor: Colors.transparent,
        ),
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              Flexible(
                flex: 5,
                child: _Header(),
              ),
              SizedBox(height: 16),
              Flexible(
                flex: 4,
                child: IconButtonsList(),
              ),
              Flexible(
                flex: 2,
                child: IconButtonContainerBig(
                  iconButton: IconButtonModel(
                    icon: Icons.logout,
                    label: 'Sair',
                    color: kSecondaryColor,
                    onTap: ModularUtils.signOut,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatefulWidget {
  const _Header({Key? key}) : super(key: key);

  @override
  State<_Header> createState() => _HeaderState();
}

class _HeaderState extends State<_Header> {
  User _user = const User.empty();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      bloc: Modular.get<AuthBloc>(),
      builder: (context, state) {
        if (state is AuthLogged) {
          _user = state.user;
        }
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
                child: AvatarContainer(user: _user),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.2,
                child: Column(
                  children: [
                    Text(
                      _user.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      _user.email,
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
      },
    );
  }
}
