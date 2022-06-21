import 'package:edufly/utile/constants.dart';
import 'package:flutter/material.dart';

enum SingingCharacter { client, designer }

class UserTypeRadio extends StatefulWidget {
  const UserTypeRadio({Key? key}) : super(key: key);

  @override
  State<UserTypeRadio> createState() => _UserTypeRadioState();
}

class _UserTypeRadioState extends State<UserTypeRadio> {
  SingingCharacter? _character = SingingCharacter.client;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
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
            mainAxisSize: MainAxisSize.min,
            children: [
              Radio<SingingCharacter>(
                value: SingingCharacter.client,
                groupValue: _character,
                onChanged: (SingingCharacter? value) {
                  setState(() {
                    _character = value;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('زبون',
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
            mainAxisSize: MainAxisSize.min,
            children: [
              Radio<SingingCharacter>(
                value: SingingCharacter.designer,
                groupValue: _character,
                onChanged: (SingingCharacter? value) {
                  setState(() {
                    _character = value;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('مصمم',
                    style: TextStyle(
                      fontFamily: fontFamilayTajawal,
                    )),
              ),
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
