import 'package:e_markety_client/features/user/components/person_details_view.dart';
import 'package:e_markety_client/features/user/components/security_view.dart';
import 'package:e_markety_client/shared/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

const spacer = SizedBox(height: 12);

class AboutMeScreen extends StatefulWidget {
  const AboutMeScreen({Key? key}) : super(key: key);

  @override
  State<AboutMeScreen> createState() => _AboutMeScreenState();
}

class _AboutMeScreenState extends State<AboutMeScreen> {
  int _selectedIndex = 0;

  static const _widgetOptions = <Widget>[
    PersonDetailsFormView(),
    SecurityFormView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.buildAppBar(title: 'Sobre Mim'),
      resizeToAvoidBottomInset: false,
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Dados Pessoais',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.security),
            label: 'Segurança',
          ),
        ],
      ),
    );
  }
}
