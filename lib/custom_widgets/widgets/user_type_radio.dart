import 'package:edufly/provider/AppProvider.dart';
import 'package:edufly/utile/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum SingingCharacter { client, freelancer }

class UserTypeRadio extends StatefulWidget {
  const UserTypeRadio({Key? key}) : super(key: key);

  @override
  State<UserTypeRadio> createState() => _UserTypeRadioState();
}

class _UserTypeRadioState extends State<UserTypeRadio> {
  SingingCharacter? _character = SingingCharacter.client;
  String valueCategory = 'Designer';

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'نوع الحساب :',
          style: TextStyle(
            fontFamily: fontFamilayTajawal,
            color: kPrimaryColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                blurRadius: 7,
                color: Colors.grey,
                offset: Offset(1, 1),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Radio<SingingCharacter>(
                value: SingingCharacter.client,
                groupValue: _character,
                onChanged: (SingingCharacter? value) {
                  setState(() {
                    _character = value;
                    Provider.of<AppProvider>(context, listen: false).setUserType(_character);
                    print("user type $_character");
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text('مستخدم',
                    style: TextStyle(
                      fontFamily: fontFamilayTajawal,
                    )),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                blurRadius: 7,
                color: Colors.grey,
                offset: Offset(1, 1),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: [
              Radio<SingingCharacter>(
                value: SingingCharacter.freelancer,
                groupValue: _character,
                onChanged: (SingingCharacter? value) {
                  setState(() {
                    _character = value;
                    Provider.of<AppProvider>(context, listen: false).setUserType(_character);

                    print('value of user type :$_character');

                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text('عضو',
                    style: TextStyle(
                      fontFamily: fontFamilayTajawal,
                    )),
              ),
              PopupMenuButton(
                position: PopupMenuPosition.under,
                onSelected: (value) {
                  // your logic
                  valueCategory = value.toString() ;
                  print('value of freelancer category :$valueCategory');

                  Provider.of<AppProvider>(context,listen: false).setFreelancerCategory(valueCategory);
                },
                itemBuilder: (BuildContext bc) {
                  return const [
                    PopupMenuItem(
                      child: Text("مصمم",
                          style: TextStyle(
                              fontFamily: fontFamilayTajawal,
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: kPrimaryColor)),
                      value: 'Designer',
                    ),
                    PopupMenuItem(
                      child: Text("محامي",
                          style: TextStyle(
                              fontFamily: fontFamilayTajawal,
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: kPrimaryColor)),
                      value: 'Lawyer',
                    ),
                  ];
                },
              )
            ],
          ),
        ),
        //
        // ListTile(
        //   title: const Text('زبون'),
        //   leading: Radio<SingingCharacter>(
        //     value: SingingCharacter.client,
        //     groupValue: _character,
        //     onChanged: (SingingCharacter? value) {
        //       setState(() {
        //         _character = value;
        //       });
        //     },
        //   ),
        // ),
        // SizedBox(
        //   width: 12,
        // ),
        // ListTile(
        //   title: const Text('مصمم'),
        //   leading: Radio<SingingCharacter>(
        //     value: SingingCharacter.designer,
        //     groupValue: _character,
        //     onChanged: (SingingCharacter? value) {
        //       setState(() {
        //         _character = value;
        //       });
        //     },
        //   ),
        // ),
      ],
    );
  }
}
