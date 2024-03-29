import 'package:e_markety_client/features/order/address/blocs/address/address_bloc.dart';
import 'package:e_markety_client/features/order/address/components/address_container.dart';
import 'package:e_markety_client/shared/theme/constants.dart';
import 'package:e_markety_client/shared/utils/modular_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../models/address.dart';

class EditAddressScreen extends StatelessWidget {
  EditAddressScreen({Key? key, required this.id}) : super(key: key);

  final String id;
  final bloc = Modular.get<AddressBloc>();

  void _onSubmit(Address address) {
    bloc.add(AddressEditEvent(address));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Editar Endereço',
          style: TextStyle(color: kBasicDarkColor),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: kBasicDarkColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.white,
      body: BlocListener<AddressBloc, AddressState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is AddressEditSuccess) {
            ModularUtils.showSuccess('Endereço editado');
            Navigator.pop(context, state.address);
          }
          if (state is AddressError) {
            ModularUtils.showError('Erro: ${state.message}');
          }
        },
        child: BlocBuilder<AddressBloc, AddressState>(
          bloc: bloc..add(AddressGetByIdEvent(int.parse(id))),
          builder: (context, state) {
            if (state is AddressLoaded) {
              return AddressContainer(
                textButton: 'Salvar',
                address: state.address,
                onSubmitAddress: _onSubmit,
              );
            }

            if (state is AddressLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return Container();
          },
        ),
      ),
    );
  }
}
