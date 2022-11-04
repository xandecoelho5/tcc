import 'package:e_markety_client/features/user/components/avatar_container.dart';
import 'package:e_markety_client/features/user/components/icon_buttons_list.dart';
import 'package:e_markety_client/features/user/models/user.dart';
import 'package:e_markety_client/shared/theme/constants.dart';
import 'package:e_markety_client/shared/utils/bloc_utils.dart';
import 'package:flutter/material.dart';

import '../../../shared/widgets/custom_app_bar.dart';
import '../components/icon_button_container_big.dart';
import '../components/icon_button_model.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key, required this.user}) : super(key: key);

  final User user;

  Padding _header(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 66, bottom: 24),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(height: MediaQuery.of(context).size.height * 0.32),
          Positioned(
            bottom: 0,
            height: 160,
            width: MediaQuery.of(context).size.width - 32,
            child: Container(
              decoration: BoxDecoration(
                color: kSecondaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: AvatarContainer(url: user.avatarUrl),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.23, // 205
            child: Column(
              children: [
                Text(
                  user.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  user.email,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.buildAppBar(
        context,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            children: [
              _header(context),
              const IconButtonsList(),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  IconButtonContainerBig(
                    iconButton: IconButtonModel(
                      icon: Icons.logout,
                      label: 'Sair',
                      color: kSecondaryColor,
                      onTap: BlocUtils.signOut,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
