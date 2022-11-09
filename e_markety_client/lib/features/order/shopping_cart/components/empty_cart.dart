import 'package:e_markety_client/shared/theme/constants.dart';
import 'package:e_markety_client/shared/widgets/filled_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 8,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                  const Icon(
                    Icons.shopping_bag_outlined,
                    size: 150,
                    color: kPrimaryColor,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  const Text(
                    'Seu carrinho está vazio!',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Text(
                    'Faça sua cesta feliz e adicione produtos para comprar',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade600,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: FilledButton(
              text: 'Começar a comprar',
              color: kSecondaryColor,
              onPressed: () => Modular.to.navigate('/home/'),
            ),
          ),
        ],
      ),
    );
  }
}
