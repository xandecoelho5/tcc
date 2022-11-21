import 'package:e_markety_client/features/order/order/components/order_view.dart';
import 'package:e_markety_client/shared/theme/constants.dart';
import 'package:e_markety_client/shared/utils/modular_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class OrderResultScreen extends StatelessWidget {
  const OrderResultScreen({Key? key, required this.isSuccess})
      : super(key: key);

  final bool isSuccess;

  @override
  Widget build(BuildContext context) {
    if (isSuccess) {
      return OrderView(
        title: 'Pedido realizado',
        mainMessage: 'Seu pedido foi realizado com sucesso!',
        subMessage: '''
Obrigado por fazer um pedido. 
Você receberá uma resposta em alguns minutos...
''',
        buttonText: 'Rastrear pedido',
        backgroundColor: kSecondaryColor,
        buttonColor: kBasicDarkColor,
        onButtonPressed: () => Modular.to.pushNamed('/order/track-order'),
      );
    }

    return const OrderView(
      title: 'Pedido recusado',
      mainMessage: 'Seu pedido foi recusado',
      subMessage: '''
Desculpe, parece que alguma coisa deu errado. '
Por favor, tente novamente mais tarde.'
''',
      buttonText: 'Tentar novamente',
      backgroundColor: kBasicDarkColor,
      buttonColor: kPrimaryColor,
      onButtonPressed: ModularUtils.goToHome,
    );
  }
}
