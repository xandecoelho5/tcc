import 'package:e_markety_client/shared/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/services/snack_bar/snackbar_service.dart';
import '../../../../shared/theme/constants.dart';
import '../../../../shared/widgets/filled_button.dart';
import '../blocs/address/address_bloc.dart';
import '../components/address_list.dart';

class AddressScreen extends StatelessWidget {
  AddressScreen({Key? key}) : super(key: key);

  final bloc = Modular.get<AddressBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.buildAppBar(
        context,
        title: 'Meus Endereços',
        showAction: false,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 8,
            child: BlocListener<AddressBloc, AddressState>(
              bloc: bloc,
              listener: (context, state) {
                if (state is AddressError) {
                  Modular.get<ISnackBarService>()
                      .showError(context, state.message);
                }
                if (state is AddressAddSuccess) {
                  Modular.get<ISnackBarService>()
                      .showSuccess(context, 'Endereço adicionado');
                }
                if (state is AddressDeletedSuccess) {
                  Modular.get<ISnackBarService>()
                      .showSuccess(context, 'Endereço deletado');
                }
              },
              child: BlocBuilder<AddressBloc, AddressState>(
                bloc: bloc..add(AddressGetAllEvent()),
                buildWhen: (prev, curr) {
                  if (prev is AddressListLoaded && curr is AddressError) {
                    return false;
                  }
                  return true;
                },
                builder: (context, state) {
                  if (state is AddressListLoaded) {
                    return AddressList(addresses: state.addresses);
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              child: FilledButton(
                text: 'Adicionar Endereço',
                onPressed: () async {
                  await Modular.to.pushNamed('/address/add');
                  bloc.add(AddressGetAllEvent());
                },
                color: kSecondaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
