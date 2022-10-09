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
    icon: Icons.payments,
    label: 'My Payment',
    onTap: () {},
  ),
  IconButtonModel(
    icon: Icons.favorite,
    label: 'My Favourite',
    onTap: () {},
  ),
  IconButtonModel(
    icon: Icons.circle_notifications_outlined,
    label: 'Transactions',
    onTap: () {},
  ),
  IconButtonModel(
    icon: Icons.discount,
    label: 'Promocode',
    onTap: () {},
  ),
  IconButtonModel(
    icon: Icons.location_on,
    label: 'My Address',
    onTap: () {},
  ),
  IconButtonModel(
    icon: Icons.notifications,
    label: 'Notification',
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

  _row(icon1, icon2, icon3) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButtonContainer(iconButton: icon1),
        const SizedBox(width: 16),
        IconButtonContainer(iconButton: icon2),
        const SizedBox(width: 16),
        IconButtonContainer(iconButton: icon3),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _row(iconButtons[0], iconButtons[1], iconButtons[2]),
        const SizedBox(height: 16),
        _row(iconButtons[3], iconButtons[4], iconButtons[5]),
        const SizedBox(height: 16),
        _row(iconButtons[6], iconButtons[7], iconButtons[8]),
      ],
    );
  }
}
