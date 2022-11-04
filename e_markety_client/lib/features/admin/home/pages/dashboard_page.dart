import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../user/auth/blocs/auth_bloc.dart';
import '../../shared/widgets/empty_container.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      bloc: Modular.get<AuthBloc>(),
      builder: (context, state) {
        if (state is AuthLogged) {
          return EmptyContainer(text: 'Bem-vindo ${state.user.name}');
        }
        return const EmptyContainer(text: 'Carregando dados...');
      },
    );
  }
}
