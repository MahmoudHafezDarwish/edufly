import 'package:Design/pages/admin/admin_app.dart';
import 'package:Design/pages/admin/dashboard/dashboard_screen.dart';
import 'package:Design/pages/admin/dashboard/main_screen.dart';
import 'package:Design/pages/auth/Profile.dart';
import 'package:Design/pages/auth/privacy_policy.dart';
import 'package:Design/pages/courses/CoursesDetail.dart';
import 'package:Design/pages/reviewUser/feedback_screen.dart';
import 'package:flutter/material.dart';
import '../pages/HomeCustomer/FavouriteScreen.dart';
import '../pages/HomeCustomer/bottom_home_navigation.dart';
import '../pages/HomeCustomer/cart_screen.dart';
import '../pages/HomeCustomer/history_order_screen.dart';
import '../pages/HomeCustomer/home_cart_screen.dart';
import '../pages/HomeCustomer/settings_screen.dart';
import '../pages/HomeDesigner/SCREENS/createCourse.dart';
import '../pages/HomeDesigner/mainNav.dart';
import '../pages/auth/login_screen.dart';
import '../pages/auth/service_provider type.dart';
import '../pages/auth/signup_screen.dart';
import '../pages/courses/StageCourses.dart';
import '../pages/outboarding/outboarding_screen.dart';
import '../pages/payment/payment_mode.dart';
import '../pages/payment/payment_successful.dart';
import '../pages/reviewUser/rating_screen.dart';
import '../pages/splash_screen.dart';

class RouterHelper {
  RouterHelper._();

  static RouterHelper routerHelper = RouterHelper._();
  GlobalKey<NavigatorState> routerKey = GlobalKey<NavigatorState>();

  routingToSpecificWidget(Widget widget) {
    BuildContext context = routerKey.currentState!.context;
    routerKey.currentState!
        .pushReplacement(MaterialPageRoute(builder: (context) {
      return widget;
    }));
  }

  routingToSpecificWidgetWithoutPop(Widget widget) {
    BuildContext context = routerKey.currentState!.context;
    routerKey.currentState!.push(MaterialPageRoute(builder: (context) {
      return widget;
    }));
  }

  popFunction() {
    routerKey.currentState!.pop();
  }

  pushToSpecificScreenByNameWithoutPop(String screenName) {
    routerKey.currentState!.pushNamed(screenName);
  }

  pushToSpecificScreenByNameWithPop(String screenName) {
    routerKey.currentState!.pushNamed(screenName);
  }

  Map<String, Widget Function(BuildContext)> map = {
    '/splash': (context) => const SplashScreen(),
    '/OutBoardingScreen': (context) => const OutboardingScreen(),
    '/login': (context) => const LoginScreen(),
    '/signup': (context) => const SignupScreen(),
    PrivacyPolicyScreen.routeName: (context) => const PrivacyPolicyScreen(),
    '/FavouriteScreen': (context) => FavouriteScreen(),
    '/main': (context) => HomeScreenBottom(),
    '/homeCartScreen': (context) => const HomeCartScreen(),
    '/setting': (context) => const SettingScreen(),
    '/cart': (context) => const CartScreen(),
    '/detailsScreen': (context) => const HomeCartScreen(),
    '/StageCourses': (context) => const StageCourses(),
    '/CoursesDetails': (context) => CoursesDetails(productId: '',),
    '/PaymentSuccessful': (context) => const PaymentSuccessfulScreen(),
    '/PaymentMode': (context) => const PaymentMode(),
    '/RatingScreen': (context) => RatingScreen(),
    '/FeedbackScreen': (context) => FeedbackScreen(),
    '/HistoryOrderScreen': (context) => const HistoryOrderScreen(),
    CreateCourse.routeName: (ctx) => CreateCourse(),
    MainNav.routeName: (ctx) => MainNav(),
    ProfilePage.routeName: (ctx) => ProfilePage(),
    UserServiceType.routeName: (ctx) => const UserServiceType(),
    AdminApp.routeName: (ctx) => const AdminApp(),
    MainScreenAdmin.routeName: (ctx) => MainScreenAdmin(),
    DashboardScreenAdmin.routeName: (ctx) => DashboardScreenAdmin()
  };
}
