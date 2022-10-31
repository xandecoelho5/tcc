import 'package:e_markety_client/features/admin/home/components/admin_sidebar.dart';
import 'package:e_markety_client/features/user/auth/blocs/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sidebarx/sidebarx.dart';

import '../../../../shared/theme/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = SidebarXController(selectedIndex: 0, extended: true);

  @override
  void initState() {
    super.initState();
    Modular.get<AuthBloc>().add(AuthGetCurrentUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Scaffold(
          backgroundColor: Colors.white,
          drawer: AdminSidebar(controller: _controller),
          body: Row(
            children: [
              AdminSidebar(controller: _controller),
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(height: 90),
                    kDivider,
                    const Expanded(child: RouterOutlet()),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
