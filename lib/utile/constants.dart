import 'package:edufly/utile/size_config.dart';
import 'package:flutter/material.dart';

const kTextColor = Color(0xFF535353);
const kTextLightColor = Color(0xFFACACAC);

const kDefaultPaddin = 16.0;
const String appName = "E-Shopee";
const String fontFamilayTajawal = "Tajawal";
const Color dark_grey = Color(0xFF313A44);

const kPrimaryColor = Color(0xFF3A58F5);
const black = Color(0xFF000000);
const white = Color(0xFFFFFFFF);
// const kPrimaryLightColor = Color(0xFFE4EDF8);
const kPrimaryDarkColor = Color(0xFF222248);
const kPrimaryExtraLightColor = Color(0xFFF9F9F9);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xFF1ECB40),
    Color(0xFF3A58F5),
  ],
);
const kSecondaryColor = Color(0xFF9CA5B8);
const kTextColor1 = Color(0xFFBED3F0);
const kTextColorLight = Color(0xFFD7E9FF);
const kTextColor2 = Color(0xFFBDBDBD);
const Color nearlyWhite = Color(0xFFFEFEFE);
const Color grey = Color(0xFFF6F6F6);

const kAnimationDuration = Duration(milliseconds: 200);

const double screenPadding = 10;

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);
const defaultPadding = 16.0;

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";
const String FIELD_REQUIRED_MSG = "This field is required";

const String fontReqularFamily = "Besley-Regular";
const String fontBesleyBlackFamily = "BesleyBlack";
const String fontBoldFamily = "Besley-Bold";
const String fontItalicFamily = "Besley-BlackItalic";

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}

double mainMargin = 18;
double btnLoginMargin = 32;
double subMargin = 14;

double buttonRadius = 8;
double mainMarginHalf = 9;

class AppTitle extends StatelessWidget {
  String title;

  AppTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: black),
    );
  }
}
