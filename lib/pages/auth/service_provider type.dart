import 'package:edufly/utile/constants.dart';
import 'package:edufly/utile/size_config.dart';
import 'package:flutter/material.dart';

class UserServiceType extends StatefulWidget {
  static const routeName = '/UserServiceType';

  const UserServiceType({Key? key}) : super(key: key);

  @override
  _UserServiceTypeState createState() => _UserServiceTypeState();
}

class _UserServiceTypeState extends State<UserServiceType> {
  late final TextEditingController title;
  late final TextEditingController description;
  late final TextEditingController information;

  // Initial Selected Value
  String dropdownvalue = 'تصميم';

  // List of items in our dropdown menu
  var items = [
    'تصميم',
    'استشارة قانونية',
  ];

  @override
  void initState() {
    // TODO: implement initState
    title = TextEditingController();
    description = TextEditingController();
    information = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    title.dispose();
    description.dispose();
    information.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          'طلب خدمة خاصة',
          style: TextStyle(
              fontFamily: fontFamilayTajawal,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
      ),
      body: Container(
        margin: EdgeInsetsDirectional.only(top: 64),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: TextField(
                keyboardType: TextInputType.text,
                controller: title,
                maxLines: null,
                minLines: null,
                expands: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8),
                  labelText: 'أدخل عنوان الخدمة',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    fontFamily: fontFamilayTajawal,
                    color: Colors.black.withOpacity(.5),
                  ),
                  border: const OutlineInputBorder(),
                  constraints: BoxConstraints(
                      maxHeight: 60, maxWidth: SizeConfig.screenWidth * 0.8),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: TextField(
                keyboardType: TextInputType.multiline,

                // resize TextField
                maxLines: null,
                minLines: null,
                expands: true,
                // constraints :BoxConstraints(
                //
                // ),

                controller: description,
                decoration: InputDecoration(
                  labelText: 'أدخل وصف الخدمة',
                  border: const OutlineInputBorder(),
                  constraints: BoxConstraints(
                      maxHeight: 90, maxWidth: SizeConfig.screenWidth * 0.8),
                ),
              ),
            ),
            Row(
              children: [
                Text('نوع الخدمة :',
                    style: TextStyle(
                        fontFamily: fontFamilayTajawal,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor)),
                SizedBox(
                  width: 5,
                ),
                DropdownButton(
                  // Initial Value
                  value: dropdownvalue,

                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),

                  // Array list of items
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
                ),
              ],
            ),
            Container(
              width: 400,
              height: 50,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('طلب الخدمة',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: fontFamilayTajawal,
                    )),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(15.0)),
                  primary: kPrimaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
