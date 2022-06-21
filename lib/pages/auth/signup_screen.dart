import 'package:edufly/utile/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

import '../../custom_widgets/widgets/user_type_radio.dart';
import '../../utile/constants.dart';
import '../../utile/tost.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late TextEditingController _email;
  late TextEditingController _phone;
  late TextEditingController _firstName;

  // late TextEditingController _address;
  late TextEditingController _password;

  // late TextEditingController _ideNumber;
  bool isPassword = true;
  var formKey;
  bool isAccept = false;
  bool verfyConditions = false;

  @override
  void initState() {
    // TODO: implement initState
    _email = TextEditingController();
    _password = TextEditingController();
    // _ideNumber = TextEditingController();
    _phone = TextEditingController();
    _firstName = TextEditingController();
    // _address = TextEditingController();
    isPassword = true;
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _email.dispose();
    _password.dispose();
    _phone.dispose();
    _firstName.dispose();
    // _address.dispose();
    // _ideNumber.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Sign up'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData.fallback(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, top: 20, right: 10),
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsetsDirectional.only(
                      top: 1,
                    ),
                    child: Text(
                      "حسابي",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: fontFamilayTajawal,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "انشئ حساب",
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.2),
                      fontFamily: fontFamilayTajawal,
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: SizeConfig.screenWidth * 0.9,
                    color: Colors.white,
                    margin: EdgeInsetsDirectional.only(
                        start: 25, end: 25, bottom: 25),
                    child: SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        // autovalidateMode:AutovalidateMode.onUserInteraction,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.text,
                              controller: _firstName,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 20,
                                fontFamily: fontFamilayTajawal,
                                color: kPrimaryColor,
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'First name must not be null';
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (value) {
                                print(value);
                              },
                              decoration: InputDecoration(
                                hintText: "الاسم",
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
                              height: 10,
                            ),
                            // TextFormField(
                            //   keyboardType: TextInputType.text,
                            //   controller: _ideNumber,
                            //   style: TextStyle(
                            //     fontWeight: FontWeight.normal,
                            //     fontSize: 20,
                            //     fontFamily: "Besley-Medium",
                            //     color: kPrimaryColor,
                            //   ),
                            //   validator: (value) {
                            //     if (value!.isEmpty) {
                            //       return 'First name must not be null';
                            //     } else {
                            //       return null;
                            //     }
                            //   },
                            //   onSaved: (value) {
                            //     print(value);
                            //   },
                            //   decoration: InputDecoration(
                            //     hintText: "رقم الهوية",
                            //     prefixIcon: Icon(
                            //       Icons.numbers,
                            //       color: kPrimaryColor,
                            //     ),
                            //     hintStyle: TextStyle(
                            //       fontWeight: FontWeight.w400,
                            //       fontSize: 20,
                            //       fontFamily: "Besley-Regular",
                            //       color: Colors.black.withOpacity(.5),
                            //     ),
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 10,
                            // ),

                            // TextFormField(
                            //   keyboardType: TextInputType.text,
                            //   controller: _address,
                            //   style: TextStyle(
                            //     fontWeight: FontWeight.normal,
                            //     fontSize: 20,
                            //     fontFamily: "Besley-Medium",
                            //     color: kPrimaryColor,
                            //   ),
                            //   validator: (value) {
                            //     if (value!.isEmpty) {
                            //       return 'Address must not be null';
                            //     } else {
                            //       return null;
                            //     }
                            //   },
                            //   decoration: InputDecoration(
                            //     hintText: "العنوان",
                            //     prefixIcon: Icon(
                            //       Icons.person,
                            //       color: kPrimaryColor,
                            //     ),
                            //     hintStyle: TextStyle(
                            //       fontWeight: FontWeight.w400,
                            //       fontSize: 20,
                            //       fontFamily: "Besley-Regular",
                            //       color: Colors.black.withOpacity(.5),
                            //     ),
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: _email,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 20,
                                fontFamily: fontFamilayTajawal,
                                color: kPrimaryColor,
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Email must not be null';
                                } else {
                                  bool valid = isEmail(value);
                                  valid
                                      ? ToastMessage.showToast("isEmail", valid)
                                      : ToastMessage.showToast(
                                          "is Not Email", valid);
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "البريد الالكتروني",
                                prefixIcon: Icon(
                                  Icons.email,
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
                              height: 10,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              controller: _phone,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 20,
                                fontFamily: fontFamilayTajawal,
                                color: kPrimaryColor,
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Phone number must not be null';
                                } else {
                                  bool valid = isNumeric(value);
                                  valid
                                      ? ToastMessage.showToast("isPhone", valid)
                                      : ToastMessage.showToast(
                                          "is Not Email", valid);

                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "رقم الهاتف",
                                prefixIcon: Icon(
                                  Icons.phone,
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
                              height: 10,
                            ),
                            SizedBox(
                              height: 45,
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                textAlignVertical: TextAlignVertical.center,
                                controller: _password,
                                obscureText: isPassword,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 20,
                                  fontFamily: fontFamilayTajawal,
                                  color: kPrimaryColor,
                                ),
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
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: kPrimaryColor,
                                  ),
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
                              height: 20,
                            ),
                            UserTypeRadio(),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 50,
                              // margin: EdgeInsetsDirectional.only(start: 10,end: 10),
                              // padding: EdgeInsetsDirectional.only(start: 10,end: 10),
                              child: Stack(
                                children: [
                                  Positioned(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Checkbox(
                                            value: verfyConditions,
                                            onChanged: (value) {
                                              setState(() {
                                                verfyConditions =
                                                    !verfyConditions;
                                              });
                                            },
                                            activeColor: kPrimaryColor,
                                          ),
                                        ),
                                        Expanded(
                                            child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'I agree to the ',
                                                style: TextStyle(
                                                    color: kPrimaryColor
                                                        .withOpacity(0.6),
                                                    fontSize: 16),
                                              ),
                                              TextSpan(
                                                text: 'Terms & Conditions',
                                                style: TextStyle(
                                                    color: kPrimaryColor,
                                                    decoration: TextDecoration
                                                        .underline,
                                                    fontSize: 16),
                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () {
                                                        // single tapped
                                                      },
                                              ),
                                              TextSpan(
                                                text: ' and ',
                                                style: TextStyle(
                                                    color: kPrimaryColor
                                                        .withOpacity(0.6),
                                                    fontSize: 16),
                                              ),
                                              TextSpan(
                                                text: 'Privacy Policy ',
                                                style: TextStyle(
                                                    color: kPrimaryColor,
                                                    decoration: TextDecoration
                                                        .underline,
                                                    fontSize: 16),
                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () {
                                                        // long pressed
                                                      },
                                              ),
                                            ],
                                          ),
                                        )),
                                      ],
                                    ),
                                    left: -15,
                                    width: MediaQuery.of(context).size.width -
                                        3 * mainMargin,
                                  ),
                                ],
                              ),
                            ),
                            // FormField(
                            //   validator: (isValid) {},
                            //   onSaved: (value) {},
                            //   builder: (context) {
                            //     return CheckboxListTile(
                            //       value: this.isAccept,
                            //       onChanged: (v) {},
                            //       title: Text('قبول الشروط :'),
                            //     );
                            //   },
                            // ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: RaisedButton(
                                padding: EdgeInsetsDirectional.only(
                                    bottom: 20, top: 20, start: 20, end: 20),
                                onPressed: () {
                                  // signUp();
                                  if (formKey.currentState.validate()) {
                                    ToastMessage.showToast("Is Done", true);

                                    print(
                                        "Email: ${_email.text}  Password : ${_password.text}");
                                  } else {
                                    ToastMessage.showToast(
                                        "User name or password is empty",
                                        false);
                                  }
                                  print(
                                      "Email: ${_email.text}  Password : ${_password.text}");
                                },
                                color: kPrimaryColor,
                                textColor: Colors.white70,
                                child: Text(
                                  "تسجيل الحساب",
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 20,
                                    fontFamily: "Tajawal",
                                    color: Colors.white,
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
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

// void signUp() {
//   if (formKey.currentState.validate()) {
//     ToastMessage.showToast("Is Done", true);
//     Navigator.pushNamed(context, "/main");
//   } else {
//     ToastMessage.showToast("Data is empty", false);
//   }
//   if (_email.text.isNotEmpty &&
//       _password.text.isNotEmpty &&
//       _firstName.text.isNotEmpty &&
//       _address.text.isNotEmpty &&
//       _phone.text.isNotEmpty) {
//     MyUser myUser = MyUser(
//       email: _email.text,
//       password: _password.text,
//       address: _address.text,
//       name: _firstName.text,
//       phoneNumber: _phone.text,
//       display_picture: null,
//       favourite_products: null,
//     );
//     Provider.of<AppProvider>(context, listen: false).signUp(myUser);
//     // ToastMessage.showToast("Is Done", true);
//     // Navigator.pushNamed(context, "/main");
//   }
//   // else if ((_email.text.isNotEmpty && _email.text == 'admin@gmail.com') &&
//   //     (_password.text.isNotEmpty && _password.text == 'admin') &&
//   //     _firstName.text.isNotEmpty &&
//   //     _address.text.isNotEmpty &&
//   //     _phone.text.isNotEmpty) {
//   //   MyUser myUser = MyUser(
//   //       email: _email.text,
//   //       password: _password.text,
//   //       address: _address.text,
//   //       name: _firstName.text,
//   //       phoneNumber: _phone.text,
//   //   isAdmin: true);
//   //   Provider.of<AppProvider>(context,listen: false).signUp(myUser);
//   //
//   //   // ToastMessage.showToast("Data is empty", false);
//   // }
// }
}
