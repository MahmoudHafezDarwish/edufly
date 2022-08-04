import 'dart:io';
import 'package:edufly/provider/AppProvider.dart';
import 'package:edufly/utile/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loggy/loggy.dart';
import 'package:provider/provider.dart';

import '../../../models/modelsFirebase/my_product.dart';
import '../../../utile/size_config.dart';

class CreateCourse extends StatefulWidget {
  static const routeName = '/createCourse';

  _CreateCourseState createState() => _CreateCourseState();
}

class _CreateCourseState extends State<CreateCourse> {
  CroppedFile? _pickedImage;
  late String image_path;

  File? _pickedFile;

  bool loading = false;
  var picker = ImagePicker();
  late TextEditingController _title;

  late TextEditingController _description;
  late TextEditingController _noOfCourses;

  late TextEditingController _courseLinke;

  late TextEditingController _priceCourse;

  late TextEditingController highlightsFieldController;
  late TextEditingController desciptionFieldController;
  late TextEditingController sellerFieldController;
  late GlobalKey _describeProductFormKey;
  String productTypeValue = 'كتب جامعية';
  List<String> productTypeValuesList = [
    'كتب جامعية',
    'المرحلة الثانوية',
    'المرحلة الإعدادية',
    'رياض الأطفال',
  ];

  @override
  void initState() {
    // TODO: implement initState
    _describeProductFormKey = GlobalKey<FormState>();
    picker = ImagePicker();
    _title = TextEditingController();
    _description = TextEditingController();
    _courseLinke = TextEditingController();
    _priceCourse = TextEditingController();
    _noOfCourses = TextEditingController();
    desciptionFieldController = TextEditingController();
    highlightsFieldController = TextEditingController();
    sellerFieldController = TextEditingController();
    super.initState();
  }

  void dispose() {
    // Clean up the controller when the widget is disposed.
    _title.dispose();
    _description.dispose();
    _courseLinke.dispose();
    _priceCourse.dispose();
    _noOfCourses.dispose();
    desciptionFieldController.dispose();
    highlightsFieldController.dispose();
    sellerFieldController.dispose();
    super.dispose();
  }

  _loadPicker(ImageSource source) async {
    File _image;
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);

        _cropImage(_image);
      } else {
        print('No image selected.');
      }
    });
  }

  _cropImage(File picked) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: picked.path,
      aspectRatioPresets: [CropAspectRatioPreset.square],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: kPrimaryColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        )
      ],
      maxWidth: 400,
    );

    if (croppedFile != null) {
      setState(() {
        _pickedImage = croppedFile;
        _pickedFile = File(_pickedImage!.path);
      });
    }
  }

  // uploadFromStorage() async {
  //   var image = await ImagePicker().pickImage(
  //     source: ImageSource.gallery,
  //   );
  //
  //   setState(() {
  //     _pickedFile = image;
  //   });
  //   print("pickImage is null : ${image} ");
  //   if (image != null) {
  //     print("pickImage : ${image!.path} ");
  //     cropImage(image);
  //   }
  // }
  //
  // cropImage(var image) async {
  //   CroppedFile? croppedFile = await ImageCropper().cropImage(
  //     sourcePath: _image!.path,
  //     aspectRatioPresets: [
  //       CropAspectRatioPreset.square,
  //       CropAspectRatioPreset.ratio3x2,
  //       CropAspectRatioPreset.original,
  //       CropAspectRatioPreset.ratio4x3,
  //       CropAspectRatioPreset.ratio16x9
  //     ],
  //     uiSettings: [
  //       AndroidUiSettings(
  //           toolbarTitle: 'Cropper',
  //           toolbarColor: Colors.deepOrange,
  //           toolbarWidgetColor: Colors.white,
  //           initAspectRatio: CropAspectRatioPreset.original,
  //           lockAspectRatio: false),
  //       IOSUiSettings(
  //         title: 'Cropper',
  //       ),
  //     ],
  //   );
  //   setState(() {
  //     _image = croppedFile!;
  //     print('image path$_image');
  //   });
  // }

  createCourseReq() async {
    setState(() {
      loading = true;
    });
    //
    // if (_title.text != null && _description.text != null && _image != null) {
    //   Provider.of<CourseProvider>(context, listen: false)
    //       .CreateCourse(_title.text, _description.text, _image)
    //       .then((_) => {
    //             setState(() {
    //               loading = false;
    //             })
    //           });
    // }
  }

  double borderRadius = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'إضافة مساق',
            style: TextStyle(
              fontFamily: fontFamilayTajawal,
              fontSize: 24,
            ),
          ),
          backgroundColor: kPrimaryColor,
        ),
        body: SingleChildScrollView(
            child: Container(
          padding: EdgeInsets.all(20),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: TextField(
                    controller: _title,
                    textInputAction: TextInputAction.next,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      fontFamily: fontFamilayTajawal,
                      color: kPrimaryColor,
                    ),
                    decoration: InputDecoration(
                      labelText: 'أدخل عنوان المساق',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        fontFamily: fontFamilayTajawal,
                        color: Colors.black.withOpacity(0.5),
                      ),
                      fillColor: kPrimaryColor,
                      floatingLabelStyle: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                        fontFamily: fontFamilayTajawal,
                        color: kPrimaryColor,
                      ),
                      focusColor: kPrimaryColor,
                      border: const OutlineInputBorder(),
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        fontFamily: fontFamilayTajawal,
                        color: Colors.black.withOpacity(.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black38,
                            // width: 5,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: kPrimaryColor,

                            // width: 5,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _description,
                          keyboardType: TextInputType.multiline,
                          style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            fontFamily: fontFamilayTajawal,
                            color: kPrimaryColor,
                          ),
                          maxLines: null,
                          decoration: InputDecoration(
                            labelText: 'أدخل وصف المساق',
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              fontFamily: fontFamilayTajawal,
                              color: Colors.black.withOpacity(0.5),
                            ),
                            fillColor: kPrimaryColor,
                            floatingLabelStyle: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 18,
                              fontFamily: fontFamilayTajawal,
                              color: kPrimaryColor,
                            ),
                            focusColor: kPrimaryColor,
                            border: const OutlineInputBorder(),
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                              fontFamily: fontFamilayTajawal,
                              color: Colors.black.withOpacity(.5),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.black38,
                                  // width: 5,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: kPrimaryColor,

                                  // width: 5,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      DropdownButton(
                        alignment: Alignment.bottomLeft,
                        value: productTypeValue,
                        items: productTypeValuesList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        // items: ProductType.values
                        //     .map(
                        //       (e) => DropdownMenuItem(
                        //         value: e,
                        //         child: Text(
                        //           EnumToString.convertToString(e),
                        //         ),
                        //       ),
                        //     )
                        //     .toList(),
                        hint: const Text(
                          "Chose Product Type",
                        ),
                        style: const TextStyle(
                          color: kTextColor,
                          fontSize: 16,
                        ),
                        onChanged: (value) {
                          // productDetails.productType = value as String;
                          setState(() {
                            productTypeValue = value as String;
                          });
                        },
                        elevation: 0,
                        underline: SizedBox(width: 0, height: 0),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    controller: highlightsFieldController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      fontFamily: fontFamilayTajawal,
                      color: kPrimaryColor,
                    ),
                    decoration: InputDecoration(
                      labelText: 'أدخل مميزات المساق',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        fontFamily: fontFamilayTajawal,
                        color: Colors.black.withOpacity(0.5),
                      ),
                      fillColor: kPrimaryColor,
                      floatingLabelStyle: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                        fontFamily: fontFamilayTajawal,
                        color: kPrimaryColor,
                      ),
                      focusColor: kPrimaryColor,
                      border: const OutlineInputBorder(),
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        fontFamily: fontFamilayTajawal,
                        color: Colors.black.withOpacity(.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black38,
                            // width: 5,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: kPrimaryColor,

                            // width: 5,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    controller: _courseLinke,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      fontFamily: fontFamilayTajawal,
                      color: kPrimaryColor,
                    ),
                    decoration: InputDecoration(
                      labelText: 'أدخل رابط المساق',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        fontFamily: fontFamilayTajawal,
                        color: Colors.black.withOpacity(0.5),
                      ),
                      fillColor: kPrimaryColor,
                      floatingLabelStyle: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                        fontFamily: fontFamilayTajawal,
                        color: kPrimaryColor,
                      ),
                      focusColor: kPrimaryColor,
                      border: const OutlineInputBorder(),
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        fontFamily: fontFamilayTajawal,
                        color: Colors.black.withOpacity(.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black38,
                            // width: 5,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: kPrimaryColor,

                            // width: 5,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _priceCourse,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          maxLines: 1,
                          style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            fontFamily: fontFamilayTajawal,
                            color: kPrimaryColor,
                          ),
                          decoration: InputDecoration(
                            labelText: 'أدخل سعر المساق',
                            suffixText: 'ريال سعودي',
                            suffixStyle: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              fontFamily: fontFamilayTajawal,
                              color: Colors.black.withOpacity(0.5),
                            ),
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              fontFamily: fontFamilayTajawal,
                              color: Colors.black.withOpacity(0.5),
                            ),
                            fillColor: kPrimaryColor,
                            floatingLabelStyle: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 18,
                              fontFamily: fontFamilayTajawal,
                              color: kPrimaryColor,
                            ),
                            focusColor: kPrimaryColor,
                            border: const OutlineInputBorder(),
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                              fontFamily: fontFamilayTajawal,
                              color: Colors.black.withOpacity(.5),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.black38,
                                  // width: 5,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: kPrimaryColor,

                                  // width: 5,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextField(
                          controller: _noOfCourses,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            fontFamily: fontFamilayTajawal,
                            color: kPrimaryColor,
                          ),
                          maxLines: null,
                          decoration: InputDecoration(
                            labelText: 'أدخل عدد الدروس',
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              fontFamily: fontFamilayTajawal,
                              color: Colors.black.withOpacity(0.5),
                            ),
                            fillColor: kPrimaryColor,
                            floatingLabelStyle: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 18,
                              fontFamily: fontFamilayTajawal,
                              color: kPrimaryColor,
                            ),
                            focusColor: kPrimaryColor,
                            border: const OutlineInputBorder(),
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                              fontFamily: fontFamilayTajawal,
                              color: Colors.black.withOpacity(.5),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.black38,
                                  // width: 5,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: kPrimaryColor,

                                  // width: 5,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: const Text('أدخل صورة الغلاف للمساق',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ))),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: InkWell(
                    onTap: () => {
                      // uploadFromStorage(),
                      _loadPicker(ImageSource.gallery)
                    },
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(borderRadius),
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 7,
                              color: Colors.grey,
                              offset: Offset(0, 3),
                            ),
                          ]),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(borderRadius),
                        // child: Image(
                        //   image: AssetImage('images/cat1.png'),
                        //   fit: BoxFit.fitHeight,
                        // ),
                        child: _pickedImage != null
                            ? Image.file(File(_pickedImage!.path))
                            : const Image(
                                image: AssetImage('images/placeholder.png'),
                                fit: BoxFit.fitHeight,
                              ),
                      ),
                    ),
                  ),
                ),
                Container(
                    width: double.infinity,
                    height: 50,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: loading == false
                        ? RaisedButton(
                            onPressed: () {
                              addNewProducts();
                              // await createCourseReq(),
                              // Navigator.pop(context)
                            },
                            color: kPrimaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: const Text('Create course',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white)))
                        : const CircularProgressIndicator()),
              ],
            ),
          ),
        )));
  }

  addNewProducts() {
    String nameOfCourse = _title.text;
    String description = _description.text;
    String linkeOfCourses = _courseLinke.text;
    String price = _priceCourse.text;
    String noOfCourse = _noOfCourses.text;
    String highlightCourse = highlightsFieldController.text;

    String myid = FirebaseAuth.instance.currentUser!.uid;

    MyProduct myProduct = MyProduct(
        owner_id: myid,
        name: nameOfCourse,
        description: description,
        linkOfCourse: linkeOfCourses,
        price: num.parse(price),
        categoryOfCourses: productTypeValue,
        numberOfCourse: noOfCourse,
        highlightCourse: highlightCourse,
        pickedImageFile: _pickedFile);
    Provider.of<AppProvider>(context, listen: false).addProduct(myProduct);
  }

  // Widget buildSellerField() {
  //   return TextFormField(
  //     controller: sellerFieldController,
  //     keyboardType: TextInputType.name,
  //     style: TextStyle(
  //       fontWeight: FontWeight.normal,
  //       fontSize: 16,
  //       fontFamily: fontFamilayTajawal,
  //       color: kPrimaryColor,
  //     ),
  //     decoration: InputDecoration(
  //       hintText: "مثل : محمد محمود",
  //       labelText: "البائع",
  //       labelStyle: TextStyle(
  //         fontWeight: FontWeight.normal,
  //         fontSize: 16,
  //         fontFamily: fontFamilayTajawal,
  //         color: Colors.black.withOpacity(0.5),
  //       ),
  //       fillColor: kPrimaryColor,
  //       floatingLabelStyle: TextStyle(
  //         fontWeight: FontWeight.normal,
  //         fontSize: 18,
  //         fontFamily: fontFamilayTajawal,
  //         color: kPrimaryColor,
  //       ),
  //       focusColor: kPrimaryColor,
  //       floatingLabelBehavior: FloatingLabelBehavior.always,
  //     ),
  //     validator: (_) {
  //       if (sellerFieldController.text.isEmpty) {
  //         return FIELD_REQUIRED_MSG;
  //       }
  //       return null;
  //     },
  //     autovalidateMode: AutovalidateMode.onUserInteraction,
  //   );
  // }
  //
  // Widget buildDescriptionField() {
  //   return TextFormField(
  //     controller: desciptionFieldController,
  //     keyboardType: TextInputType.multiline,
  //     style: TextStyle(
  //       fontWeight: FontWeight.normal,
  //       fontSize: 16,
  //       fontFamily: fontFamilayTajawal,
  //       color: kPrimaryColor,
  //     ),
  //     decoration: InputDecoration(
  //       hintText: "بوربوينت مميز وبشرح سلس ومبسط لكل درس بالمنهج.",
  //       labelText: "وصف المحتوى",
  //       labelStyle: TextStyle(
  //         fontWeight: FontWeight.normal,
  //         fontSize: 16,
  //         fontFamily: fontFamilayTajawal,
  //         color: Colors.black.withOpacity(0.5),
  //       ),
  //       fillColor: kPrimaryColor,
  //       floatingLabelStyle: TextStyle(
  //         fontWeight: FontWeight.normal,
  //         fontSize: 18,
  //         fontFamily: fontFamilayTajawal,
  //         color: kPrimaryColor,
  //       ),
  //       focusColor: kPrimaryColor,
  //       floatingLabelBehavior: FloatingLabelBehavior.always,
  //     ),
  //     validator: (_) {
  //       if (desciptionFieldController.text.isEmpty) {
  //         return FIELD_REQUIRED_MSG;
  //       }
  //       return null;
  //     },
  //     autovalidateMode: AutovalidateMode.onUserInteraction,
  //     maxLines: null,
  //   );
  // }
  //
  // Widget buildHighlightsField() {
  //   return TextFormField(
  //     controller: highlightsFieldController,
  //     keyboardType: TextInputType.multiline,
  //     style: TextStyle(
  //       fontWeight: FontWeight.normal,
  //       fontSize: 16,
  //       fontFamily: fontFamilayTajawal,
  //       color: kPrimaryColor,
  //     ),
  //     decoration: InputDecoration(
  //       hintText:
  //           "مثل: جميع دروس المنهج وعددها 7 دروس بحسب نظام الثلاثة فصول..الخ",
  //       labelText: "مميزات",
  //       labelStyle: TextStyle(
  //           fontWeight: FontWeight.normal,
  //           fontSize: 16,
  //           fontFamily: fontFamilayTajawal,
  //           color: Colors.black.withOpacity(0.5),
  //           overflow: TextOverflow.fade),
  //       fillColor: kPrimaryColor,
  //       floatingLabelStyle: TextStyle(
  //         fontWeight: FontWeight.normal,
  //         fontSize: 18,
  //         fontFamily: fontFamilayTajawal,
  //         color: kPrimaryColor,
  //       ),
  //       focusColor: kPrimaryColor,
  //       floatingLabelBehavior: FloatingLabelBehavior.always,
  //     ),
  //     validator: (_) {
  //       if (highlightsFieldController.text.isEmpty) {
  //         return FIELD_REQUIRED_MSG;
  //       }
  //       return null;
  //     },
  //     autovalidateMode: AutovalidateMode.onUserInteraction,
  //     maxLines: null,
  //   );
  // }
  //
  // Widget buildDescribeProductTile(BuildContext context) {
  //   return Form(
  //     key: _describeProductFormKey,
  //     child: ExpansionTile(
  //       maintainState: true,
  //       title: Text(
  //         "وصف المنتج",
  //         style: TextStyle(
  //           color: Colors.black,
  //           fontWeight: FontWeight.bold,
  //           fontSize: 20,
  //           fontFamily: fontFamilayTajawal,
  //         ),
  //       ),
  //       leading: Icon(
  //         Icons.description,
  //       ),
  //       childrenPadding: EdgeInsets.symmetric(
  //           vertical: getProportionateScreenHeight(20), horizontal: 10),
  //       children: [
  //         buildHighlightsField(),
  //         SizedBox(height: getProportionateScreenHeight(20)),
  //         buildDescriptionField(),
  //         SizedBox(height: getProportionateScreenHeight(20)),
  //       ],
  //     ),
  //   );
  // }
}
