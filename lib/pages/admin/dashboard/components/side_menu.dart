import 'package:Design/gen/assets.gen.dart';
import 'package:Design/utile/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset(Assets.images.cat4.path),
          ),
          DrawerListTile(
            title: "لوحة التحكم الرئيسية",
            svgSrc: Assets.icons.menuDashbord,
            press: () {},
          ),
          DrawerListTile(
            title: "تفاصيل الطلبات",
            svgSrc: Assets.icons.menuTran,
            press: () {},
          ),
          // DrawerListTile(
          //   title: "Task",
          //   svgSrc: Assets.icons.menuTask,
          //   press: () {},
          // ),
          DrawerListTile(
            title: "الكتب و التصاميم",
            svgSrc: Assets.icons.menuDoc,
            press: () {},
          ),
          // DrawerListTile(
          //   title: "Store",
          //   svgSrc: Assets.icons.menuStore,
          //   press: () {},
          // ),
          // DrawerListTile(
          //   title: "Notification",
          //   svgSrc: Assets.icons.menuNotification,
          //   press: () {},
          // ),
          DrawerListTile(
            title: "حسابي",
            svgSrc: Assets.icons.menuProfile,
            press: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.language,
              color: kPrimaryColor,
            ),
            title: Text(
              'تغيير اللغة',
              style: TextStyle(
                  color: Colors.black, fontFamily: fontFamilayTajawal),
            ),
            onTap: () {
              // showLanguageBottomSheet();
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
            title: Text(
              'تسجيل خروج',
              style: TextStyle(
                  color: Colors.black, fontFamily: fontFamilayTajawal),
            ),
            onTap: () {
              // showAleertDialog();
            },
          ),
          // DrawerListTile(
          //   title: "الإ",
          //   svgSrc: Assets.icons.menuSetting,
          //   press: () {},
          // ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: kPrimaryColor,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.black, fontFamily: fontFamilayTajawal),
      ),
    );
  }
}
