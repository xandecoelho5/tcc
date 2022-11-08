import 'package:e_markety_client/core/services/snack_bar/snackbar_service.dart';
import 'package:e_markety_client/features/admin/settings/components/company_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../company/blocs/company/company_bloc.dart';

class CompanySettingsPage extends StatefulWidget {
  const CompanySettingsPage({Key? key}) : super(key: key);

  @override
  State<CompanySettingsPage> createState() => _CompanySettingsPageState();
}

class _CompanySettingsPageState extends State<CompanySettingsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<CompanyBloc, CompanyState>(
      bloc: Modular.get<CompanyBloc>(),
      listener: (context, state) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (state is CompanySuccessState) {
            Modular.get<ISnackBarService>()
                .showSuccess(context, 'Dados salvos');
          }
          if (state is CompanyErrorState) {
            Modular.get<ISnackBarService>()
                .showError(context, 'Erro ao salvar dados: ${state.message}');
          }
        });
      },
      child: BlocBuilder<CompanyBloc, CompanyState>(
        bloc: Modular.get<CompanyBloc>()..add(CompanyGetCurrentEvent()),
        builder: (context, state) {
          if (state is CompanyLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CompanyLoadedCurrentState) {
            return CompanyContainer(company: state.company);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
