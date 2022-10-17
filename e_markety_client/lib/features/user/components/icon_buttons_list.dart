import 'package:e_markety_client/features/user/components/icon_button_container.dart';
import 'package:flutter/material.dart';

import 'icon_button_model.dart';

final List<IconButtonModel> iconButtons = [
  IconButtonModel(
    icon: Icons.person,
    label: 'About Me',
    onTap: () {},
  ),
  IconButtonModel(
    icon: Icons.shopping_bag,
    label: 'My Orders',
    onTap: () {},
  ),
  IconButtonModel(
    icon: Icons.favorite,
    label: 'My Favourite',
    onTap: () {},
  ),
  IconButtonModel(
    icon: Icons.location_on,
    label: 'My Address',
    onTap: () {},
  ),
  IconButtonModel(
    icon: Icons.settings_outlined,
    label: 'Settings',
    onTap: () {},
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
            const SizedBox(width: 16),
            IconButtonContainer(iconButton: iconButtons[2]),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButtonContainer(iconButton: iconButtons[3]),
            const SizedBox(width: 16),
            IconButtonContainer(iconButton: iconButtons[4]),
          ],
        ),
      ],
    );
  }
}
