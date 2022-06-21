import 'dart:io';
import 'package:edufly/utile/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class CreateCourse extends StatefulWidget {
  static const routeName = '/createCourse';

  _CreateCourseState createState() => _CreateCourseState();
}

class _CreateCourseState extends State<CreateCourse> {
  CroppedFile? _pickedImage;
  late String image_path;

  XFile? _pickedFile;

  bool loading = false;
  final picker = ImagePicker();
  final _title = TextEditingController();
  final _description = TextEditingController();
  final _courseLinke = TextEditingController();

  void dispose() {
    // Clean up the controller when the widget is disposed.
    _title.dispose();
    _description.dispose();
    _courseLinke.dispose();
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
          title: Text('إضافة مساق'),
          backgroundColor: kPrimaryColor,
        ),
        body: SingleChildScrollView(
            child: Container(
          padding: EdgeInsets.all(20),
          child: new Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: TextField(
                    controller: _title,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      fontFamily: "Besley-Medium",
                      color: kPrimaryColor,
                    ),
                    decoration: InputDecoration(
                      labelText: 'أدخل عنوان المساق',
                      fillColor: kPrimaryColor,
                      floatingLabelStyle: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                        fontFamily: "Besley-Medium",
                        color: kPrimaryColor,
                      ),
                      focusColor: kPrimaryColor,
                      border: const OutlineInputBorder(),
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        fontFamily: "Besley-Regular",
                        color: Colors.black.withOpacity(.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black38,
                            // width: 5,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
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
                    controller: _description,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      labelText: 'أدخل وصف المساق',
                      fillColor: kPrimaryColor,
                      floatingLabelStyle: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                        fontFamily: "Besley-Medium",
                        color: kPrimaryColor,
                      ),
                      focusColor: kPrimaryColor,
                      border: const OutlineInputBorder(),
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        fontFamily: "Besley-Regular",
                        color: Colors.black.withOpacity(.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black38,
                            // width: 5,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
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
                    decoration: InputDecoration(
                      labelText: 'أدخل رابط المساق',
                      fillColor: kPrimaryColor,
                      floatingLabelStyle: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                        fontFamily: "Besley-Medium",
                        color: kPrimaryColor,
                      ),
                      focusColor: kPrimaryColor,
                      border: const OutlineInputBorder(),
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        fontFamily: "Besley-Regular",
                        color: Colors.black.withOpacity(.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black38,
                            // width: 5,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: kPrimaryColor,

                            // width: 5,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Text('أدخل صورة الغلاف للمساق',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ))),
                Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
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
                                borderRadius:
                                    BorderRadius.circular(borderRadius),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 7,
                                    color: Colors.grey,
                                    offset: Offset(0, 3),
                                  ),
                                ]),
                            child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(borderRadius),
                                // child: Image(
                                //   image: AssetImage('images/cat1.png'),
                                //   fit: BoxFit.fitHeight,
                                // ),
                                child: _pickedImage != null
                                    ? Image.file(File(_pickedImage!.path))
                                    : Image(
                                        image: AssetImage(
                                            'images/placeholder.png'),
                                        fit: BoxFit.fitHeight,
                                      ))))),
                Container(
                    width: double.infinity,
                    height: 50,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: loading == false
                        ? new RaisedButton(
                            onPressed: () async => {
                                  await createCourseReq(),
                                  Navigator.pop(context)
                                },
                            child: const Text('Create course',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white)),
                            color: kPrimaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(15.0)))
                        : CircularProgressIndicator()),
              ],
            ),
          ),
        )));
  }
}
