import 'package:edufly/pages/admin/dashboard/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controllers/MenuController.dart';
class AdminApp extends StatelessWidget {
  static const routeName = '/AdminApp';

  const AdminApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MenuController(),
        ),
      ],
      child: MainScreenAdmin(),
    );
  }
}
