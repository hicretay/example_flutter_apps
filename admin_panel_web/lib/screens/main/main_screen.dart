import 'package:admin_panel_web/contollers/MenuController.dart';
import 'package:admin_panel_web/responsive.dart';
import 'package:admin_panel_web/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';

import 'components/side_menu.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuController>().scaffoldKey,
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(
                context)) // sideMenu sadece desktopta kullanılacak
              Expanded(
                // varsayılan flex:1 ekranın 1/6'sını alır
                child: SideMenu(),
              ),
            Expanded(
              flex: 5,
              child: DashboardScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
