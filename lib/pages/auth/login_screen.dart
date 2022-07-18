import 'package:edufly/utile/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../provider/AppProvider.dart';
import '../../utile/size_config.dart';
import '../../utile/tost.dart';
import '../HomeDesigner/mainNav.dart';
import '../admin/admin_app.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static  String typeUser = 'user' ;


  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _email;
  late TextEditingController _password;
  var formKey;
  late bool isPassword;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
    formKey = GlobalKey<FormState>();
    isPassword = true;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, top: 30, right: 10),
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Container(
                  //   margin: EdgeInsetsDirectional.only(top: 20,bottom: 20),
                  //   width: 80,
                  //   height: 80,
                  //   alignment: Alignment.center,
                  //   decoration: BoxDecoration(
                  //     color: Colors.red,
                  //     shape: BoxShape.circle,
                  //     image: DecorationImage(
                  //         fit: BoxFit.cover,
                  //         image: NetworkImage(
                  //             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSDvHHeO_OvqgXATx3pqefutpdJ8pntH1wphGBTScJ4Ir29RJwmA5-1O2KP2rQQEX-AW8s&usqp=CAU")),
                  //   ),
                  // ),
                  Container(
                    margin: EdgeInsetsDirectional.only(
                      top: 80,
                    ),
                    child: Text(
                      "تسجيل دخول",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: fontFamilayTajawal,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 9,
                  ),
                  Text(
                    "تسجيل دخول للبدء في استخدام التطبيق",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: fontFamilayTajawal,
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(
                    height: 36,
                  ),
                  Container(
                    width: 319,
                    height: 270,
                    color: Colors.white,
                    margin: EdgeInsetsDirectional.only(start: 28, end: 28),
                    child: SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              textDirection:TextDirection.ltr,

                              keyboardType: TextInputType.emailAddress,
                              controller: _email,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 20,
                                fontFamily: fontFamilayTajawal,
                                color: kPrimaryColor,
                              ),
                              onChanged: (value) {
                                print("_passord${_email.text}");
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Email must not be null';
                                } else {
                                  return null;
                                }
                              },
                              onFieldSubmitted: (value) {
                                print(value);
                              },
                              decoration: InputDecoration(
                                hintText: "البريد الالكتروني",
                                // enabledBorder: OutlineInputBorder(
                                //     borderSide: BorderSide(
                                //       color: Colors.black,
                                //       width: 5,
                                //     ),
                                //     borderRadius: BorderRadius.circular(10)),
                                // focusedBorder: OutlineInputBorder(
                                //     borderSide: BorderSide(
                                //       color: Colors.black,
                                //       width: 5,
                                //     ),
                                //     borderRadius: BorderRadius.circular(10)),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: kPrimaryColor,
                                ),

                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                  fontFamily: fontFamilayTajawal,
                                  color: Colors.black.withOpacity(.5),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 28,
                            ),
                            SizedBox(
                              height: 45,
                              child: TextFormField(
                                textDirection:TextDirection.ltr,
                                keyboardType: TextInputType.visiblePassword,
                                textAlignVertical: TextAlignVertical.center,
                                controller: _password,
                                obscureText: isPassword,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 20,
                                  fontFamily: fontFamilayTajawal,
                                  color: kPrimaryColor,
                                ),
                                onChanged: (value) {
                                  print("_passord${_password.text}");
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Password must not be null';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(

                                  contentPadding:
                                      EdgeInsetsDirectional.only(start: 10),
                                  hintText: "كلمة السر",
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      isPassword
                                          ? Icons.remove_red_eye
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isPassword = !isPassword;
                                      });
                                    },
                                  ),

                                  // enabledBorder: OutlineInputBorder(
                                  //   borderSide: BorderSide(
                                  //     color: Colors.white,
                                  //     style: BorderStyle.solid,
                                  //     width: 5,
                                  //   ),
                                  //   borderRadius: BorderRadius.circular(10),
                                  // ),
                                  // focusedBorder: OutlineInputBorder(
                                  //   borderSide: BorderSide(
                                  //     color: Colors.white,
                                  //     width: 5,
                                  //   ),
                                  //   borderRadius: BorderRadius.circular(10),
                                  // ),
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: kPrimaryColor,
                                  ),
                                  hintStyle: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 20,
                                    fontFamily: fontFamilayTajawal,
                                    color: Colors.black.withOpacity(.5),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: RaisedButton(
                                padding: EdgeInsetsDirectional.all(20),
                                onPressed: () {
                                  if (formKey.currentState.validate()) {
                                    print(
                                        "Email: ${_email.text}  Password : ${_password.text}");
                                  }
                                  logIn();
                                },
                                color: kPrimaryColor,
                                textColor: Colors.white70,
                                child: Text(
                                  "تسجيل دخول",
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 20,
                                    fontFamily: fontFamilayTajawal,
                                    color: Colors.white,
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'ليس لديك حساب في التطبيق ؟',
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                      fontFamily: fontFamilayTajawal,
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/signup');
                                    },
                                    child: Text(
                                      'تسجيل حساب',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        fontFamily: fontFamilayTajawal,
                                        color: kPrimaryColor,
                                          // decoration: TextDecoration
                                          //     .underline,
                                        decorationStyle: TextDecorationStyle.solid,
                                        decorationThickness: 5,
                                        decorationColor: Colors.black,

                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void logIn() {
    if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
      //Navigator.pushReplacementNamed(context, '/main');
      // Navigator.pushReplacementNamed(context, '/main');
      Provider.of<AppProvider>(context, listen: false)
          .login(_email.text, _password.text);
      // ToastMessage.showToast("Is Done", true);
    } else {
      ToastMessage.showToast("User name or password is empty", false);
    }
  }

  void oldlogIn() {
    String passText = _password.text.toString();
    if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
      // Navigator.pushReplacementNamed(context, '/main');
      // Provider.of<AppProvider>(context, listen: false)
      //     .login(_email.text, _password.text);
      if (_email.text.toString() == 'user' && passText == 'user') {
        Navigator.pushReplacementNamed(context, '/main');
        ToastMessage.showToast("Is Done", true);
        LoginScreen.typeUser = 'user';

      } else if (_email.text.toString() == 'admin' && passText == 'admin') {
        Navigator.pushNamed(context, AdminApp.routeName);
        ToastMessage.showToast("Is Done", true);
      } else if (_email.text.toString() == 'designer' &&
          passText == 'designer') {
        Navigator.pushReplacementNamed(context, MainNav.routeName);
        LoginScreen.typeUser = 'designer';
        ToastMessage.showToast("Is Done", true);
      } else {
        ToastMessage.showToast("email or password is false", false);
      }
    } else {
      ToastMessage.showToast("User name or password is empty", false);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _email.dispose();
    _password.dispose();
  }
}
