import 'package:e_markety_client/shared/utils/modular_utils.dart';
import 'package:e_markety_client/shared/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

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
                  ModularUtils.showError(state.message);
                }
                if (state is AddressAddSuccess) {
                  ModularUtils.showSuccess('Endereço adicionado');
                }
                if (state is AddressDeletedSuccess) {
                  ModularUtils.showSuccess('Endereço deletado');
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
                    if (state.addresses.isEmpty) {
                      return const Center(
                        child: Text('Nenhum endereço cadastrado'),
                      );
                    }
                    return AddressList(addresses: state.addresses);
                  }
                  if (state is AddressLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return const SizedBox.shrink();
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
                onPressed: () => Modular.to.pushNamed('/address/add'),
                color: kSecondaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
