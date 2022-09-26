import 'package:Design/pages/auth/login_screen.dart';
import 'package:Design/utile/RouterHelper.dart';
import 'package:Design/utile/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/modelsFirebase/MyUsres.dart';
import '../../provider/AppProvider.dart';
import '../auth/Profile.dart';
import '../auth/service_provider type.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    MyUser myUser = Provider.of<AppProvider>(context, listen: false).loggedUser!;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 22,
            ),
            Container(
              width: 135,
              height: 135,
              child: const CircleAvatar(
           
                backgroundImage:
                    NetworkImage('https://cdn.pixabay.com/photo/2018/08/28/12/41/avatar-3637425_960_720.png'),
              ),
            ),
            SizedBox(
              height: 22,
            ),
            Text(
              myUser.name ?? 'اسم المستخدم',
              style: TextStyle(
                fontSize: 20,
                color: Color(0xff444657),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              myUser.email ?? 'username@gmail.com',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xff444657),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.person_outline,
                color: kPrimaryColor,
              ),
              title: Text('حسابي'),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 14,
              ),
              onTap: () {
                Navigator.pushNamed(context, ProfilePage.routeName);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.reorder,
                color: kPrimaryColor,
              ),
              title: Text('طلباتي السابقة'),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 14,
              ),
              onTap: () {
                Navigator.pushNamed(context, '/HistoryOrderScreen');
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, UserServiceType.routeName);
              },
              leading: Icon(
                Icons.book_online_outlined,
                color: kPrimaryColor,
              ),
              title: Text('خدمات خاصة اونلاين '),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 14,
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.star_rate_outlined,
                color: kPrimaryColor,
              ),
              title: Text('تقييم المتجر والمنتجات'),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 14,
              ),
              onTap: () {
                Navigator.pushNamed(context, "/RatingScreen");
              },
            ),
            ListTile(
              leading: Icon(
                Icons.star_rate_outlined,
                color: kPrimaryColor,
              ),
              title: const Text('استشارات قانونية'),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 14,
              ),
              onTap: () {
                Navigator.pushNamed(context, "/FeedbackScreen");
              },
            ),
            ListTile(
              leading: Icon(
                Icons.language,
                color: kPrimaryColor,
              ),
              title: const Text('حذف الحساب'),
              onTap: () {
                showLanguageBottomSheet();
              },
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 14,
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.red,
              ),
              title: Text('Log OuT'),
              onTap: () {
                showAlertDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void showAlertDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: const Text('هل أنت متأكد تريد تسجيل خروج ؟'),
            elevation: 5,
            titleTextStyle: TextStyle(color: Colors.black, fontSize: 18, fontFamily: fontFamilayTajawal),
            actions: [
              TextButton(
                onPressed: () {
                  // Navigator.pop(context);
                  Provider.of<AppProvider>(context, listen: false).logout();
                },
                style: TextButton.styleFrom(
                  primary: Colors.white70,
                  elevation: 5,
                  backgroundColor: Colors.green,
                  side: BorderSide(width: 2, color: Colors.green),
                ),
                child: Text("نعم"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white70,
                  elevation: 5,
                  backgroundColor: Colors.red,
                  side: BorderSide(width: 2, color: Colors.red),
                ),
                child: const Text("لا"),
              ),
            ],
          );
        });
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        elevation: 0,
        isDismissible: true,
        builder: (context) {
          return Container(
            margin: EdgeInsets.all(10),
            child: BottomSheet(
                elevation: 3,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      width: 1,
                      color: Colors.black,
                    )),
                onClosing: () {},
                builder: (context) {
                  return Container(
                    padding: EdgeInsets.all(10),
                    height: 120,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: TextButton.styleFrom(
                            primary: Colors.black,
                            side: BorderSide(width: 2, color: Colors.grey),
                          ),
                          child: const Text('هل أنت متأكد أنك تريد حذف بيانات حسابك ؟'),
                        ),
                        Row(
                          children: [
                            TextButton(
                              onPressed: () async {
                                bool deleted = await Provider.of<AppProvider>(context, listen: false).deleteUserData();
                                if (deleted) {
                                  RouterHelper.routerHelper.routingToSpecificWidget(const LoginScreen());
                                }
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.black,
                                side: BorderSide(width: 2, color: Colors.grey),
                              ),
                              child: const Text("نعم"),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.black,
                                side: BorderSide(width: 2, color: Colors.grey),
                              ),
                              child: const Text("إلغاء"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
          );
        });
  }
}
