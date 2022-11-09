import 'package:e_markety_client/features/user/screens/about_me_screen.dart';
import 'package:e_markety_client/features/user/screens/user_profile_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';

class UserModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/user-profile',
          child: (context, args) => const UserProfileScreen(),
        ),
        ChildRoute('/about-me', child: (_, args) => const AboutMeScreen()),
      ];
}
