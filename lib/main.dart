import 'package:edufly/pages/edit_product/provider_models/ProductDetails.dart';
import 'package:edufly/preferences/shared_pref_controller.dart';
import 'package:edufly/provider/AppProvider.dart';
import 'package:edufly/utile/RouterHelper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loggy/loggy.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SharedPrefController().initPref();
  Provider.debugCheckInvalidValueType = null;

  Loggy.initLoggy(
    logPrinter: const PrettyPrinter(
      showColors: true,
    ),
    logOptions: const LogOptions(
      LogLevel.all,
      stackTraceLevel: LogLevel.all,
    ),
  );
  runApp(const ElearningApp());
}

class ElearningApp extends StatelessWidget {
  const ElearningApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
     providers: [
            Provider<AppProvider>(create: (context) => AppProvider()),
            // Provider<ProductDetails>(create: (context) => ProductDetails()),
     ],
      child: MaterialApp(
        theme: ThemeData.light().copyWith(
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
              .apply(bodyColor: Colors.black),
        ),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en'),
          const Locale('ar'),
        ],
        locale: const Locale('ar'),
        debugShowCheckedModeBanner: false,
        navigatorKey: RouterHelper.routerHelper.routerKey,
        initialRoute: '/splash',
        routes: RouterHelper.routerHelper.map,
      ),
    );
  }
}
