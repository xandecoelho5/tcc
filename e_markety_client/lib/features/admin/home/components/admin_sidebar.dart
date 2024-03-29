import 'package:e_markety_client/features/admin/home/components/sidebar_theme.dart';
import 'package:e_markety_client/shared/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sidebarx/sidebarx.dart';

import '../../../../shared/theme/constants.dart';
import '../../../../shared/utils/modular_utils.dart';
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
      footerItems: const [
        CustomSidebarXItem(
          icon: Icons.logout,
          label: 'Logout',
          onTap: ModularUtils.signOut,
        ),
      ],
      items: [
        CustomSidebarXItem(
          icon: Icons.home_outlined,
          label: 'Dashboard',
          onTap: () => Modular.to.navigate('/admin/dashboard'), // dashboard
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
        CustomSidebarXItem(
          icon: Icons.shopping_cart_outlined,
          label: 'Bairros',
          trailing: true,
          trailingItems: [
            SidebarSubItem(
              label: 'Adicionar Bairro',
              onTap: () => Modular.to.navigate('/admin/company-district/add'),
            ),
            SidebarSubItem(
              label: 'Listar Bairros',
              onTap: () => Modular.to.navigate('/admin/company-district/'),
            ),
          ],
        ),
        CustomSidebarXItem(
          icon: Icons.shopping_bag_outlined,
          label: 'Pedidos',
          onTap: () => Modular.to.navigate('/admin/order/'),
        ),
        CustomSidebarXItem(
          icon: Icons.home_work_outlined,
          label: 'Configurações',
          onTap: () => Modular.to.navigate('/admin/settings/'),
        ),
      ],
    );
  }
}
