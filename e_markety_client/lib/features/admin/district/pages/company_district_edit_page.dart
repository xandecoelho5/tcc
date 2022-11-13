import 'package:e_markety_client/features/admin/district/components/company_district_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../shared/utils/modular_utils.dart';
import '../../../company/blocs/company_district/company_district_bloc.dart';
import '../../../company/models/company_district.dart';

class CompanyDistrictEditPage extends StatelessWidget {
  CompanyDistrictEditPage({Key? key, required this.id}) : super(key: key);

  final String id;
  final bloc = Modular.get<CompanyDistrictBloc>();

  void _onSubmit(CompanyDistrict companyDistrict) {
    bloc.add(CompanyDistrictEditEvent(companyDistrict));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CompanyDistrictBloc, CompanyDistrictState>(
      bloc: bloc,
      listener: (context, state) {
        if (state is CompanyDistrictSuccess) {
          ModularUtils.showSuccess('Bairro editado');
          Modular.to.navigate('/admin/company-district/');
        }
        if (state is CompanyDistrictError) {
          ModularUtils.showError('Erro: ${state.message}');
        }
      },
      child: BlocBuilder<CompanyDistrictBloc, CompanyDistrictState>(
        bloc: bloc..add(CompanyDistrictGetByIdEvent(int.parse(id))),
        builder: (context, state) {
          if (state is CompanyDistrictLoaded) {
            return CompanyDistrictContainer(
              companyDistrict: state.companyDistrict,
              onSubmit: _onSubmit,
              title: 'Editar Bairro',
              buttonText: 'Editar',
              districts: [state.companyDistrict.district!],
            );
          }

          if (state is CompanyDistrictLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Container();
        },
      ),
    );
  }
}
