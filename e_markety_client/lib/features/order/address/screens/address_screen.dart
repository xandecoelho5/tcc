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
  const AddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.buildAppBar(context, title: 'Meus Endereços'),
      body: Column(
        children: [
          Expanded(
            flex: 8,
            child: BlocBuilder<AddressBloc, AddressState>(
              bloc: Modular.get<AddressBloc>()..add(AddressGetAllEvent()),
              builder: (context, state) {
                if (state is AddressLoaded) {
                  return AddressList(addresses: state.addresses);
                }
                if (state is AddressError) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Modular.get<ISnackBarService>()
                        .showError(context, state.message);
                  });
                }
                return const Center(child: CircularProgressIndicator());
              },
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
                onPressed: () => Modular.to.pushNamed('/add-new-address'),
                color: kSecondaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
