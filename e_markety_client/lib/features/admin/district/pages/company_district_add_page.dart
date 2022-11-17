import 'package:e_markety_client/features/admin/shared/widgets/empty_container.dart';
import 'package:e_markety_client/features/company/models/company_district.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../shared/utils/modular_utils.dart';
import '../../../company/blocs/company_district/company_district_bloc.dart';
import '../../../order/address/models/district.dart';
import '../components/company_district_container.dart';
import '../notifiers/district_notifier.dart';

class CompanyDistrictAddPage extends StatelessWidget {
  const CompanyDistrictAddPage({Key? key}) : super(key: key);

  void _onSubmit(CompanyDistrict product) {
    Modular.get<CompanyDistrictBloc>().add(CompanyDistrictAddEvent(product));
  }

  @override
  Widget build(BuildContext context) {
    Modular.get<DistrictNotifier>().fetchData();
    return BlocListener<CompanyDistrictBloc, CompanyDistrictState>(
      bloc: Modular.get<CompanyDistrictBloc>(),
      listener: (context, state) {
        if (state is CompanyDistrictSuccess) {
          ModularUtils.showSuccess('Bairro salvo');
          Modular.to.navigate('/admin/company-district/');
        }
        if (state is CompanyDistrictError) {
          ModularUtils.showError('Erro ao salvar bairro: ${state.message}');
        }
      },
      child: ValueListenableBuilder<List<District>>(
        valueListenable: Modular.get<DistrictNotifier>(),
        builder: (context, value, child) {
          if (value.isEmpty) {
            return const EmptyContainer(
              text: 'Todos os bairros já foram cadastrados',
            );
          }
          return CompanyDistrictContainer(
            companyDistrict: const CompanyDistrict.empty(),
            onSubmit: _onSubmit,
            title: 'Adicionar Bairro',
            buttonText: 'Cadastrar',
            districts: value,
          );
        },
      ),
    );
  }
}
