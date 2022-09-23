import 'package:Design/models/modelsFirebase/consulting.dart';
import 'package:Design/utile/tost.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/AppProvider.dart';
import '../../utile/constants.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: nearlyWhite,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: nearlyWhite,
          body: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, left: 16, right: 16),
                    child: Image.asset('images/feedbackImage.png'),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 8),
                    alignment: Alignment.center,
                    child: const Text(
                      'تفضل اطلب استشارتك القانونية يوجد لدينا أفضل المحاميين و المستشاريين',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'BesleyBlack'),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 16),
                    child: const Text(
                      'امنح أفضل وقت لهذه اللحظة',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, fontFamily: 'BesleyBlack'),
                    ),
                  ),
                  _buildComposer(),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Center(
                      child: Container(
                        width: 120,
                        height: 40,
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(color: Colors.grey.withOpacity(0.6), offset: const Offset(4, 4), blurRadius: 8.0),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () async {
                              String id = await addConsulting();
                              if (id != null) {
                                ToastMessage.showToast("IS DONE ADD", true);
                              } else {
                                ToastMessage.showToast("IS failed add", true);
                              }
                            },
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  'أرسل',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildComposer() {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 32, right: 32),
      child: Container(
        decoration: BoxDecoration(
          color: nearlyWhite,
          borderRadius: BorderRadius.circular(8),
          boxShadow: <BoxShadow>[
            BoxShadow(color: Colors.grey.withOpacity(0.8), offset: const Offset(4, 4), blurRadius: 8),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Container(
            padding: const EdgeInsets.all(4.0),
            constraints: const BoxConstraints(minHeight: 80, maxHeight: 160),
            color: nearlyWhite,
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
              child: TextField(
                controller: textEditingController,
                maxLines: null,
                onChanged: (String txt) {},
                style: TextStyle(
                  fontFamily: "Besley-Regular",
                  fontSize: 16,
                  color: dark_grey,
                ),
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'أدخل استشارتك القانونية...',
                    hintStyle: TextStyle(
                      fontFamily: "Besley-Regular",
                    )),
              ),
            ),
          ),
        ),
      ),
    );
  }

  addConsulting() async {
    String textConsulting = textEditingController.text;
    String myid = FirebaseAuth.instance.currentUser!.uid;
    Consulting consulting = Consulting(textConsulting, myid);
    return await Provider.of<AppProvider>(context, listen: false).addConsulting(consulting);
  }
}
