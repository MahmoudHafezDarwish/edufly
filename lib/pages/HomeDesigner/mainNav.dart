import 'package:edufly/pages/HomeCustomer/settings_screen.dart';
import 'package:edufly/pages/auth/Profile.dart';
import 'package:edufly/utile/constants.dart';
import 'package:flutter/material.dart';

import 'SCREENS/createCourse.dart';
import 'SCREENS/enrolledCourse.dart';
import 'SCREENS/feed.dart';
import 'SCREENS/userHome.dart';

class MainNav extends StatefulWidget {
  @override
  static const routeName = '/mainNav';

  _MainNavState createState() => _MainNavState();
}

class _MainNavState extends State<MainNav> {
  int pageIndex = 0;
  List<Widget> pages = [Feed(), EnrolledCourse(), UserHomeFeed()];
  var appBarTitles = ['الرئيسية', 'الطلبات', 'تصاميمك'];

  // final FirebaseAuth _auth = FirebaseAuth.instance;
  var profile_picture;
  bool isLoading = false;

  void initState() {
    super.initState();
    print('init called');
    // Provider.of<UserProvider>(context, listen: false).signOut();
    // Provider.of<UserProvider>(context, listen: false)
    //     .getCurrentUser()
    //     .then((value) => {
    //           setState(() {
    //             isLoading = true;
    //           }),
    //           Provider.of<UserProvider>(context, listen: false)
    //               .getUser()
    //               .then((value) => {
    //                     setState(() {
    //                       profile_picture = value.profile_picture;
    //                       isLoading = false;
    //                     })
    //                   })
    //         });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == false
        ? Scaffold(
            appBar: AppBar(
                title: Text(appBarTitles[pageIndex]),
                backgroundColor: kPrimaryColor,
                actions: <Widget>[
                  pageIndex == 2
                      ? IconButton(
                          icon: const Icon(
                              IconData(0xe8a6, fontFamily: 'MaterialIcons')),
                          tooltip: 'User',
                          onPressed: ()  {
                            //async
                            // await Provider.of<UserProvider>(context,
                            //         listen: false)
                            //     .signOut();
                            // Provider.of<CoursePostProvider>(context,
                            //         listen: false)
                            //     .clearCoursePostProvider();
                            // Provider.of<CourseProvider>(context, listen: false)
                            //     .clearCourseProvider();
                            // Navigator.pushReplacement(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => Auth(),
                            //     ));
                          },
                        )
                      : Container()
                ]),
            body: pages[pageIndex],
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.white,
              elevation: 10,
              showUnselectedLabels: false,
              type: BottomNavigationBarType.fixed,
              selectedFontSize: 18,
              selectedItemColor: kPrimaryColor,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_outlined,
                  ),
                  //title: Text("Home"),
                  label: 'الرئيسية',
                  backgroundColor: Colors.blue,
                  activeIcon: Icon(Icons.home),
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(height: 20, width: 20, 'images/order.png'),
                  label: 'الطلبات',
                  activeIcon: Image.asset(
                      height: 25, width: 25, 'images/activeOrder.png'),
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.reorder,
                    ),
                    label: 'تصاميمك'),
              ],
              currentIndex: pageIndex,
              onTap: (i) {
                setState(() {
                  pageIndex = i;
                });
              },
            ),
            floatingActionButton: pageIndex == 2
                ? FloatingActionButton(
                    onPressed: () {
                      Navigator.pushNamed(context, CreateCourse.routeName);
                    },
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 30,
                    ),
                    backgroundColor: kPrimaryColor,
                  )
                : null,
            drawer: Drawer(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Column(

                    children: [
                      SizedBox(
                        height: 22,
                      ),
                      Container(
                        width: 135,
                        height: 135,
                        child: CircleAvatar(
                          // child: Image.asset(
                          //   'images/Bg.png',
                          //   width: 235,
                          //   height: 235,
                          // ),

                          backgroundImage: AssetImage('images/Bg.png'),
                        ),
                      ),
                      SizedBox(
                        height: 22,
                      ),
                      Text('اسم المستخدم',style: TextStyle(
                        fontSize: 20,
                        color: Color(0xff444657),
                      ),),
                      SizedBox(
                        height: 5,
                      ),
                      Text('username@gmail.com',style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff444657),
                      ),),
                      ListTile(
                        leading: Icon(
                          Icons.person_outline,
                          color: kPrimaryColor,
                        ),
                        title: Text('حسابي'),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                        ),
                        onTap: (){
                          Navigator.pushNamed(context, ProfilePage.routeName);

                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.reorder,
                          color: kPrimaryColor,
                        ),
                        title: Text('أرشيف الطلبات'),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                        ),
                        onTap: (){
                          Navigator.pushNamed(context, '/HistoryOrderScreen');
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.book_online_outlined,
                          color: kPrimaryColor,
                        ),
                        title: Text('خدمات خاصة اونلاين '),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.star_rate_outlined,
                          color: kPrimaryColor,
                        ),
                        title: Text('تقييم المتجر والمنتجات'),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                        ),
                        onTap: (){
                          Navigator.pushNamed(context, "/RatingScreen");
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.star_rate_outlined,
                          color: kPrimaryColor,
                        ),
                        title: Text('تقديم شكاوي'),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                        ),
                        onTap: (){
                          Navigator.pushNamed(context, "/FeedbackScreen");
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.language,
                          color: kPrimaryColor,
                        ),
                        title: Text('تغيير اللغة'),
                        onTap: () {
                          showLanguageBottomSheet();
                        },
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.logout,
                          color: Colors.red,
                        ),
                        title: Text('Log OuT'),
                        onTap: () {

                        },
                      ),
                    ],
                  ),
                )
            ),
          )
        : CircularProgressIndicator();
  }

  void showAleertDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white70,
            title: Text("Are you sure?"),
            elevation: 5,
            titleTextStyle: TextStyle(
              color: Colors.blue,
              fontSize: 18,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                  primary: Colors.white70,
                  elevation: 5,
                  backgroundColor: Colors.green,
                  side: BorderSide(width: 2, color: Colors.green),
                ),
                child: Text("Yes"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                  primary: Colors.white70,
                  elevation: 5,
                  backgroundColor: Colors.red,
                  side: BorderSide(width: 2, color: Colors.red),
                ),
                child: Text("No"),
              ),
              // InkWell(
              //   child:Text("Yes",style: TextStyle(
              //     color: Colors.green,
              //     fontSize: 18,
              //   ),) ,
              //   onTap: (){
              //
              //   },
              // ),
            ],
          );
        });
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        elevation: 0,
        isDismissible: true,
        builder: (context) {
          return Container(
            margin: EdgeInsets.all(10),
            child: BottomSheet(
                elevation: 3,
                backgroundColor: Colors.white70,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      width: 1,
                      color: Colors.black,
                    )),
                onClosing: () {},
                builder: (context) {
                  return Container(
                    padding: EdgeInsets.all(10),
                    height: 120,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: TextButton.styleFrom(
                            primary: Colors.black,
                            side: BorderSide(width: 2, color: Colors.grey),
                          ),
                          child: Text("Arabic"),
                        ),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            primary: Colors.black,
                            side: BorderSide(width: 2, color: Colors.grey),
                          ),
                          child: Text("English"),
                        ),
                        /*
                          ListTile(
                          leading: Icon(
                          Icons.language,
                          color: Colors.red,
                          ),
                          title: Text('Arabic'),
                          onTap: (){
                            showLanguageBottomSheet();
                          },
                          trailing: Icon(
                            Icons.check_circle_outline_sharp,
                            size: 14,
                          ),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.logout,
                            color: Colors.red,
                          ),
                          title: Text('English'),
                          trailing: Icon(
                            Icons.check,
                            size: 14,
                          ),
                        ),
                        */
                      ],
                    ),
                  );
                }),
          );
        });
  }
}
