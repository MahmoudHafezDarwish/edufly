
import 'package:edufly/pages/admin/admin_app.dart';
import 'package:edufly/pages/outboarding/outboarding_dot.dart';
import 'package:edufly/utile/constants.dart';
import 'package:flutter/material.dart';

import '../HomeDesigner/mainNav.dart';
import 'FirstScreen.dart';
import 'package:edufly/gen/assets.gen.dart';

class OutboardingScreen extends StatefulWidget {
  const OutboardingScreen({Key? key}) : super(key: key);

  @override
  _OutboardingScreenState createState() => _OutboardingScreenState();
}

class _OutboardingScreenState extends State<OutboardingScreen> {
  late PageController pageController;
  int currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView(
            onPageChanged: (int currentPageIndex) {
              setState(() {
                currentIndex = currentPageIndex;
              });
            },
            controller: pageController,
            children: [
              OutBoardingContentScreen(
                title: "مرحبًا بكم في متجر الكتب الإلكترونية Design",
                subTitle:
                    "استكشف الكتب الإلكترونية التعليمية في تطبيق Design",
                // image: 'images/out1.png',
                image: Assets.images.out1.path,
              ),
              OutBoardingContentScreen(
                title: "تعرف على كتابك الإلكتروني بنقرة واحدة",
                subTitle:
                    "اختيار الكتب الصحيحة في مكان واحد",
                // image: 'images/out2.png',
                image: Assets.images.out2.path,
              ),
              OutBoardingContentScreen(
                title: "يقدم لك متجر الكتب الإلكترونية Design\n ملايين الكتب الإلكترونية",
                subTitle:
                    "ملايين العناوين عبر تصنيفات مثل كتب رياض الأطفال",
                // image: 'images/out3.png',
                image: Assets.images.out3.path,
              ),
            ],
          ),
          if (currentIndex != 2)
            PositionedDirectional(
              end: 15,
              top: 30,
              child: ElevatedButton(
                onPressed: () {
                  pageController.jumpToPage(2);
                },
                child: Text(
                  'تخطي',
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 14,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  //elevation: 3,
                ),
              ),
            ),
          PositionedDirectional(
              start: 0,
              end: 0,
              bottom: 10,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutBoardingDot(
                        index: 0,
                        currentIndex: currentIndex,
                      ),
                      OutBoardingDot(
                        index: 1,
                        currentIndex: currentIndex,
                      ),
                      OutBoardingDot(
                        index: 2,
                        currentIndex: currentIndex,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (currentIndex == 2)
                    Container(
                      width: 315,
                      height: 53,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigator.pushReplacementNamed(
                          //     context, MainNav.routeName);
                          Navigator.pushNamed(context, "/login");
                          // Navigator.pushNamed(context, "/detailsScreen");
                          // Navigator.pushNamed(context, AdminApp.routeName);
                        },

                        child: Text('استمر'),
                        style: ElevatedButton.styleFrom(

                          primary: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                      ),
                    ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        child: Icon(Icons.arrow_back_ios,
                            color: currentIndex == 0
                                ? Colors.black.withOpacity(0.2)
                                : Colors.black),
                        onTap: () {
                          pageController.previousPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInBack);
                        },
                      ),
                      InkWell(
                        child: Icon(Icons.arrow_forward_ios,
                            color: currentIndex == 2
                                ? Colors.black.withOpacity(0.2)
                                : Colors.black),
                        onTap: () {
                          pageController.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeIn);
                        },
                      ),
                    ],
                  ),
                ],
              ))
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }
}
