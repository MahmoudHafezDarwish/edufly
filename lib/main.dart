import 'package:Design/preferences/shared_pref_controller.dart';
import 'package:Design/provider/AppProvider.dart';
import 'package:Design/utile/RouterHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loggy/loggy.dart';
import 'package:firebase_core/firebase_core.dart';
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
      ],
      child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              theme: ThemeData.light().copyWith(
                textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme).apply(bodyColor: Colors.black),
              ),
              localizationsDelegates: const [
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
            );
          }),
    );
  }
}
