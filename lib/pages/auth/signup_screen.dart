import 'package:edufly/utile/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart';
import 'package:loggy/loggy.dart';

import '../../custom_widgets/widgets/user_type_radio.dart';
import '../../models/modelsFirebase/MyUsres.dart';
import '../../models/modelsFirebase/freelancer.dart';
import '../../provider/AppProvider.dart';
import '../../utile/constants.dart';
import '../../utile/tost.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late TextEditingController _email;

  // late TextEditingController _phone;
  String phoneNumber = '';
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
    // _phone = TextEditingController();
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
    // _phone.dispose();
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
                    margin: EdgeInsetsDirectional.only(start: 20, end: 20, bottom: 25),
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
                            //     color: kPrimaryColor,p
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
                              textDirection: TextDirection.ltr,
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
                                      : ToastMessage.showToast("is Not Email", valid);
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

                            // TextFormField(
                            //   keyboardType: TextInputType.phone,
                            //   controller: _phone,
                            //   style: TextStyle(
                            //     fontWeight: FontWeight.normal,
                            //     fontSize: 20,
                            //     fontFamily: fontFamilayTajawal,
                            //     color: kPrimaryColor,
                            //   ),
                            //   validator: (value) {
                            //     if (value!.isEmpty) {
                            //       return 'Phone number must not be null';
                            //     } else {
                            //       bool valid = isNumeric(value);
                            //       valid
                            //           ? ToastMessage.showToast("isPhone", valid)
                            //           : ToastMessage.showToast(
                            //               "is Not Email", valid);
                            //
                            //       return null;
                            //     }
                            //   },
                            //   decoration: InputDecoration(
                            //     hintText: "رقم الهاتف",
                            //     prefixIcon: Icon(
                            //       Icons.phone,
                            //       color: kPrimaryColor,
                            //     ),
                            //     hintStyle: TextStyle(
                            //       fontWeight: FontWeight.w400,
                            //       fontSize: 20,
                            //       fontFamily: fontFamilayTajawal,
                            //       color: Colors.black.withOpacity(.5),
                            //     ),
                            //   ),
                            // ),
                            SizedBox(
                              height: 45,
                              child: TextFormField(
                                textDirection: TextDirection.ltr,
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
                                  contentPadding: EdgeInsetsDirectional.only(start: 10),
                                  hintText: "كلمة السر",
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: kPrimaryColor,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      isPassword ? Icons.remove_red_eye : Icons.visibility_off,
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
                              height: 10,
                            ),
                            IntlPhoneField(
                              style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 20,
                                fontFamily: fontFamilayTajawal,
                                color: kPrimaryColor,
                              ),
                              initialCountryCode: 'PS',
                              //default contry code, NP for Nepal

                              decoration: InputDecoration(
                                hintTextDirection: TextDirection.rtl,
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

                                // border: OutlineInputBorder(
                                //   borderSide: BorderSide(),
                                // ),
                              ),
                              onChanged: (phone) {
                                print(phone.completeNumber);
                                setState(() {
                                  phoneNumber = '${phone.completeNumber}';
                                });
                              },
                              onCountryChanged: (country) {
                                print('Country changed to: ' + country.name);
                              },
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
                                    left: -15,
                                    width: MediaQuery.of(context).size.width - 3 * mainMargin,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Checkbox(
                                            value: verfyConditions,
                                            onChanged: (value) {
                                              setState(() {
                                                verfyConditions = !verfyConditions;
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
                                                style: TextStyle(color: kPrimaryColor.withOpacity(0.6), fontSize: 16),
                                              ),
                                              TextSpan(
                                                text: 'Terms & Conditions',
                                                style: TextStyle(
                                                    color: kPrimaryColor,
                                                    decoration: TextDecoration.underline,
                                                    fontSize: 16),
                                                recognizer: TapGestureRecognizer()
                                                  ..onTap = () {
                                                    // single tapped
                                                  },
                                              ),
                                              TextSpan(
                                                text: ' and ',
                                                style: TextStyle(color: kPrimaryColor.withOpacity(0.6), fontSize: 16),
                                              ),
                                              TextSpan(
                                                text: 'Privacy Policy ',
                                                style: TextStyle(
                                                    color: kPrimaryColor,
                                                    decoration: TextDecoration.underline,
                                                    fontSize: 16),
                                                recognizer: TapGestureRecognizer()
                                                  ..onTap = () {
                                                    // long pressed
                                                  },
                                              ),
                                            ],
                                          ),
                                        )),
                                      ],
                                    ),
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
                            Consumer<AppProvider>(
                              builder: (context, provider, x) {
                                logDebug('user type before signup :${provider.userType}');

                                return SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsetsDirectional.only(bottom: 20, top: 20, start: 20, end: 20),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      backgroundColor: kPrimaryColor,
                                      textStyle: TextStyle(color: Colors.white70),
                                    ),
                                    onPressed: () {
                                      if (formKey.currentState.validate()) {
                                        signUp(provider.userType);

                                        print("Email: ${_email.text}  Password : ${_password.text}");
                                      } else {
                                        ToastMessage.showToast("Data is empty", false);
                                      }
                                      print("Email: ${_email.text}  Password : ${_password.text}");
                                    },
                                    child: Text(
                                      "تسجيل الحساب",
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 20,
                                        fontFamily: "Tajawal",
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
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

  void signUp(SingingCharacter? usertype) {
    // if (formKey.currentState.validate()) {
    //   ToastMessage.showToast("Is Done", true);
    //   Navigator.pushNamed(context, "/main");
    // } else {
    //   ToastMessage.showToast("Data is empty", false);
    // }
    if (_email.text.isNotEmpty && _password.text.isNotEmpty && _firstName.text.isNotEmpty && phoneNumber.isNotEmpty) {
      // SingingCharacter? usertype = Provider.of<AppProvider>(context,listen: false).userType;
      // SingingCharacter? usertype = context.watch<AppProvider>().userType;
      logInfo('user type ${usertype.toString()}');
      bool isFreelancer = usertype == SingingCharacter.freelancer ? true : false;
      logError('isFreelancer :$isFreelancer');
      late MyUser myUser;
      if (isFreelancer) {
        myUser = Freelancer(
            email: _email.text,
            password: _password.text,
            address: '',
            name: _firstName.text,
            phoneNumber: phoneNumber,
            display_picture: null,
            favourite_products: null,
            isFreelancer: isFreelancer ? true : false,
            freelancerCategory: Provider.of<AppProvider>(context, listen: false).freelancerCategory);
      } else {
        myUser = MyUser(
          email: _email.text,
          password: _password.text,
          address: '',
          name: _firstName.text,
          phoneNumber: phoneNumber,
          display_picture: null,
          favourite_products: null,
          isFreelancer: isFreelancer ? true : false,
        );
      }
      Provider.of<AppProvider>(context, listen: false).signUp(myUser);

      // ToastMessage.showToast("Is Done", true);
      // Navigator.pushNamed(context, "/main");
    }
    // else if ((_email.text.isNotEmpty && _email.text == 'admin@gmail.com') &&
    //     (_password.text.isNotEmpty && _password.text == 'admin') &&
    //     _firstName.text.isNotEmpty &&
    //     _address.text.isNotEmpty &&
    //     _phone.text.isNotEmpty) {
    //   MyUser myUser = MyUser(
    //       email: _email.text,
    //       password: _password.text,
    //       address: _address.text,
    //       name: _firstName.text,
    //       phoneNumber: _phone.text,
    //   isAdmin: true);
    //   Provider.of<AppProvider>(context,listen: false).signUp(myUser);
    //
    //   // ToastMessage.showToast("Data is empty", false);
    // }
  }
}
