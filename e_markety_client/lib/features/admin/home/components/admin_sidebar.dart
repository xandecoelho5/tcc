import 'package:e_markety_client/features/admin/home/components/sidebar_theme.dart';
import 'package:e_markety_client/shared/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sidebarx/sidebarx.dart';

import '../../../../shared/theme/constants.dart';
import '../../../user/auth/blocs/auth_bloc.dart';
import 'custom_sidebarx/custom_sidebarx.dart';
import 'custom_sidebarx/custom_sidebarx_item.dart';

class AdminSidebar extends StatelessWidget {
  const AdminSidebar({Key? key, required this.controller}) : super(key: key);

  final SidebarXController controller;

  Container _roundedAvatar(ImageProvider<Object> image) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      height: 75,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: image,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomSidebarX(
      controller: controller,
      theme: SidebarTheme.build(),
      extendedTheme: SidebarTheme.buildExtended(),
      showToggleButton: false,
      footerItems: const [
        CustomSidebarXItem(
          icon: Icons.logout,
          label: 'Logout',
        ),
      ],
      headerDivider: kDivider,
      headerBuilder: (context, extended) {
        return BlocBuilder<AuthBloc, AuthState>(
          bloc: Modular.get<AuthBloc>(),
          builder: (context, state) {
            if (state is AuthLogged) {
              return _roundedAvatar(NetworkImage(state.user.avatarUrl));
            }
            return _roundedAvatar(const AssetImage(Assets.avatarPlaceholder));
          },
        );
      },
      items: [
        CustomSidebarXItem(
          icon: Icons.home_outlined,
          label: 'Dashboard',
          onTap: () => Modular.to.navigate('/admin/'),
        ),
        CustomSidebarXItem(
          icon: Icons.shopping_cart_outlined,
          label: 'Produtos',
          trailing: true,
          trailingItems: [
            SidebarSubItem(
              label: 'Adicionar Produto',
              onTap: () => Modular.to.navigate('/admin/product/add'),
            ),
            SidebarSubItem(
              label: 'Listar Produtos',
              onTap: () => Modular.to.navigate('/admin/product/'),
            ),
          ],
        ),
        const CustomSidebarXItem(
          icon: Icons.shopping_bag_outlined,
          label: 'Pedidos',
        ),
        const CustomSidebarXItem(
          icon: Icons.home_work_outlined,
          label: 'Configurações',
        ),
      ],
    );
  }
}
