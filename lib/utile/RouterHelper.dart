import 'package:edufly/pages/admin/admin_app.dart';
import 'package:edufly/pages/admin/dashboard/dashboard_screen.dart';
import 'package:edufly/pages/admin/dashboard/main_screen.dart';
import 'package:edufly/pages/auth/Profile.dart';
import 'package:edufly/pages/courses/CoursesDetail.dart';
import 'package:edufly/pages/reviewUser/feedback_screen.dart';
import 'package:flutter/material.dart';

import '../pages/HomeCustomer/FavouriteScreen.dart';
import '../pages/HomeCustomer/bottom_home_navigation.dart';
import '../pages/HomeCustomer/cart_screen.dart';
import '../pages/HomeCustomer/history_order_screen.dart';
import '../pages/HomeCustomer/home_cart_screen.dart';
import '../pages/HomeCustomer/settings_screen.dart';
import '../pages/HomeDesigner/SCREENS/addPostInCourse.dart';
import '../pages/HomeDesigner/SCREENS/courseDetail.dart';
import '../pages/HomeDesigner/SCREENS/createCourse.dart';
import '../pages/HomeDesigner/SCREENS/enrolledCourse.dart';
import '../pages/HomeDesigner/SCREENS/feed.dart';
import '../pages/HomeDesigner/SCREENS/userHome.dart';
import '../pages/HomeDesigner/courseNav.dart';
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
    '/splash': (context) => SplashScreen(),
    '/OutBoardingScreen': (context) => OutboardingScreen(),
    '/login': (context) => LoginScreen(),
    '/signup': (context) => SignupScreen(),
    '/FavouriteScreen': (context) => FavouriteScreen(),
    '/main': (context) => HomeScreenBottom(),
    '/homeCartScreen': (context) => HomeCartScreen(),
    '/setting': (context) => SettingScreen(),
    '/cart': (context) => CartScreen(),
    '/detailsScreen': (context) => HomeCartScreen(),
    '/StageCourses': (context) => StageCourses(),
    '/CoursesDetails': (context) => CoursesDetails(),
    '/PaymentSuccessful': (context) => PaymentSuccessfulScreen(),
    '/PaymentMode': (context) => PaymentMode(),
    '/RatingScreen': (context) => RatingScreen(),
    '/FeedbackScreen': (context) => FeedbackScreen(),
    '/HistoryOrderScreen': (context) => HistoryOrderScreen(),
    CourseDetail.routeName: (ctx) => CourseDetail(),
    CreateCourse.routeName: (ctx) => CreateCourse(),
    AddPostCourse.routeName: (ctx) => CreateCourse(),
    MainNav.routeName: (ctx) => MainNav(),
    CourseNav.routeName: (ctx) => CourseNav(),
    Feed.routeName: (ctx) => CourseNav(),
    UserHomeFeed.routeName: (ctx) => CourseNav(),
    EnrolledCourse.routeName: (ctx) => CourseNav(),
    ProfilePage.routeName: (ctx) => ProfilePage(),
    UserServiceType.routeName: (ctx) => UserServiceType(),
    AdminApp.routeName: (ctx) => AdminApp(),
    MainScreenAdmin.routeName: (ctx) => MainScreenAdmin(),
    DashboardScreenAdmin.routeName: (ctx) => DashboardScreenAdmin()
  };
}
