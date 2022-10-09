import 'package:e_markety_client/features/user/components/user_info_container.dart';
import 'package:e_markety_client/features/user/models/user.dart';
import 'package:e_markety_client/shared/mocks/mocks.dart';
import 'package:e_markety_client/shared/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class AboutMeScreen extends StatelessWidget {
  const AboutMeScreen({Key? key}) : super(key: key);

  final User user = userMock;

  @override
  Widget build(BuildContext context) {
    const spacer = SizedBox(height: 8);

    return Scaffold(
      appBar: CustomAppBar.buildAppBar(context, title: 'About Me'),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Personal Details',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              UserInfoContainer(text: user.name, icon: Icons.person),
              spacer,
              UserInfoContainer(text: user.email, icon: Icons.email),
              spacer,
              UserInfoContainer(text: addressMock[0].phone, icon: Icons.phone),
              const SizedBox(height: 48),
              const Text(
                'Personal Details',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const UserInfoContainer(
                text: 'Current Password',
                icon: Icons.lock,
              ),
              spacer,
              const UserInfoContainer(text: 'New Password', icon: Icons.lock),
              spacer,
              const UserInfoContainer(
                text: 'Confirm Password',
                icon: Icons.lock,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
