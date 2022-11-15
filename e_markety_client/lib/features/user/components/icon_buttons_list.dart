import 'package:e_markety_client/features/user/components/icon_button_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'icon_button_model.dart';

final List<IconButtonModel> iconButtons = [
  IconButtonModel(
    icon: Icons.person,
    label: 'Sobre Mim',
    onTap: () => Modular.to.pushNamed('/user/about-me'),
  ),
  IconButtonModel(
    icon: Icons.shopping_bag,
    label: 'Meus Pedidos',
    onTap: () => Modular.to.pushNamed('/order/my-orders'),
  ),
  IconButtonModel(
    icon: Icons.favorite,
    label: 'Meus Favoritos',
    onTap: () => Modular.to.pushNamed('/favourite/'),
  ),
  IconButtonModel(
    icon: Icons.location_on,
    label: 'Meus Endereços',
    onTap: () => Modular.to.pushNamed('/address/'),
  ),
];

class IconButtonsList extends StatelessWidget {
  const IconButtonsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButtonContainer(iconButton: iconButtons[0]),
            const SizedBox(width: 16),
            IconButtonContainer(iconButton: iconButtons[1]),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButtonContainer(iconButton: iconButtons[2]),
            const SizedBox(width: 16),
            IconButtonContainer(iconButton: iconButtons[3]),
          ],
        ),
      ],
    );
  }
}
