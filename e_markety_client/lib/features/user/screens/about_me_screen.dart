import 'package:e_markety_client/features/order/address/blocs/default_address/default_address_bloc.dart';
import 'package:e_markety_client/features/user/auth/blocs/auth_bloc.dart';
import 'package:e_markety_client/features/user/components/user_info_container.dart';
import 'package:e_markety_client/features/user/models/user.dart';
import 'package:e_markety_client/shared/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

const spacer = SizedBox(height: 8);

class AboutMeScreen extends StatelessWidget {
  const AboutMeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.buildAppBar(context, title: 'Sobre Mim'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Detalhes Pessoais',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              BlocBuilder<AuthBloc, AuthState>(
                bloc: Modular.get<AuthBloc>(),
                builder: (context, state) {
                  User? user;
                  if (state is AuthLogged) {
                    user = state.user;
                  }
                  return Column(
                    children: [
                      UserInfoContainer(
                        text: user?.name ?? 'Não carregou o nome',
                        icon: Icons.person,
                      ),
                      spacer,
                      UserInfoContainer(
                        text: user?.email ?? 'Não carregou o email',
                        icon: Icons.email,
                      ),
                    ],
                  );
                },
              ),
              spacer,
              BlocBuilder<DefaultAddressBloc, DefaultAddressState>(
                bloc: Modular.get<DefaultAddressBloc>(),
                builder: (context, state) {
                  if (state is DefaultAddressError) {
                    return UserInfoContainer(
                      text: state.message,
                      icon: Icons.phone,
                    );
                  }

                  if (state is DefaultAddressLoaded) {
                    return UserInfoContainer(
                      text: state.address.phone,
                      icon: Icons.phone,
                    );
                  }

                  return const UserInfoContainer(
                    text: 'Não carregou o telefone',
                    icon: Icons.phone,
                  );
                },
              ),
              const SizedBox(height: 24),
              const Text(
                'Segurança',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const UserInfoContainer(
                text: 'Senha Atual',
                icon: Icons.lock,
              ),
              spacer,
              const UserInfoContainer(text: 'Nova Senha', icon: Icons.lock),
              spacer,
              const UserInfoContainer(
                text: 'Confirmar Senha',
                icon: Icons.lock,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
