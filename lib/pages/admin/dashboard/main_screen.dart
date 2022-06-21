
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/responsive.dart';
import '../controllers/MenuController.dart';
import 'components/side_menu.dart';
import 'dashboard_screen.dart';

class MainScreenAdmin extends StatelessWidget {
  static const routeName = '/MainScreenAdmin';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuController>().scaffoldKey,
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: DashboardScreenAdmin(),
            ),
          ],
        ),
      ),
    );
  }
}
