import 'package:edufly/utile/constants.dart';
import 'package:edufly/utile/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../custom_widgets/widgets/LinearGradientText.dart';
import '../../custom_widgets/widgets/categorries.dart';
import '../../custom_widgets/widgets/order_card.dart';
import '../../custom_widgets/widgets/products_section.dart';
import '../../gen/assets.gen.dart';

class OrdersSreen extends StatefulWidget {
  OrdersSreen({Key? key}) : super(key: key);

  @override
  _OrdersSreenState createState() => _OrdersSreenState();
}

class _OrdersSreenState extends State<OrdersSreen> {
  // final FavouriteProductsStream favouriteProductsStream =
  //     FavouriteProductsStream();
  // final AllProductsStream allProductsStream = AllProductsStream();
  // CategoryProductsStream categoryProductsStream = CategoryProductsStream(p);
/*
*
    for(ProductType p in ProductType.values ){
      if(Provider.of<AppProvider>(context).category==p.toString()){
        categoryProductsStream = CategoryProductsStream(p);
      }
    }*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // favouriteProductsStream.init();
    // allProductsStream.init();
    // categoryProductsStream.init();
  }

  @override
  void dispose() {
    // favouriteProductsStream.dispose();
    // allProductsStream.dispose();
    // categoryProductsStream.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        children: [
          Stack(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.topCenter,
                width: double.infinity,
                height: 322,
                color: Color(0xff3A58F5),
                // margin: EdgeInsetsDirectional.only(start: 5, end: 10, top: 5),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12, top: 45.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.only(start: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'مرحبا بك,',
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Color(0xffffffff),
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Text(
                              'تطبيق الكتب الإلكترونية',
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Color(0xffffffff),
                                fontSize: 19,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Image.asset(
                        color: Colors.white,
                        fit: BoxFit.fill,
                        height: 38.6,
                        width: 38.6,
                        'images/study.png',
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: CircleAvatar(
                            backgroundColor: kPrimaryExtraLightColor,
                            child: Icon(
                              color: kPrimaryColor,
                              Icons.notifications,
                              size: 35,
                            )),
                      ),

                      SizedBox(
                        width: 7,
                      )
                      // Categories(),
                      // SizedBox(height: 15,),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 105.0, bottom: 5),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          shape: BoxShape.rectangle),
                      margin: EdgeInsets.only(right: 8, left: 8),
                      child: ListTile(
                        leading: SizedBox(
                          height: 19.54,
                          width: 19.54,
                          child: Icon(
                            Icons.search_rounded,
                            color: kTextColor2,
                          ),
                        ),
                        style: ListTileStyle.list,
                        title: TextField(
                          decoration: InputDecoration(
                            hintText: "بحث عن كتاب",
                            hintStyle: TextStyle(
                                color: Colors.black45,
                                fontFamily: fontFamilayTajawal,
                                fontWeight: FontWeight.normal),
                            fillColor: kPrimaryExtraLightColor,
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                        ),
                        trailing: Image(
                          image: AssetImage('images/filtter.png'),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                        side: BorderSide(
                          color: Colors.white,
                          width: 1,
                        ),
                      ),
                      elevation: 5,
                      color: Colors.white,
                      margin: EdgeInsetsDirectional.only(start: 8, end: 8, top: 10),
                      child: Container(
                        height: 210,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            right: 24.5,
                            left: 17,
                            top: 15,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GradientText(
                                    ' edufly',
                                    gradient: kPrimaryGradientColor,
                                    style: const TextStyle(
                                        fontFamily: 'BesleyBlack',
                                        fontWeight: FontWeight.w900,
                                        fontSize: 24,
                                        color: Colors.black,
                                        backgroundColor: Colors.transparent),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    'اكتشف ملايين\nالكتب المدرسية\nلجميع الفصول',
                                    style: TextStyle(
                                        fontFamily: 'BesleyBlack',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: Colors.black,
                                        backgroundColor: Colors.transparent),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    padding: EdgeInsetsDirectional.only(
                                        top: 7, bottom: 8, start: 14, end: 21),
                                    decoration: BoxDecoration(
                                        color: kTextColorLight,
                                        borderRadius: BorderRadius.circular(30),
                                        shape: BoxShape.rectangle),
                                    child: InkWell(
                                      onTap: () {},
                                      child: Text('معرفة المزيد'),
                                    ),
                                  ),
                                ],
                              ),
                              Image(
                                image: AssetImage('images/out3.png'),
                                width: 172,
                                height: 156.49,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsetsDirectional.only(top: 11),
            padding: const EdgeInsetsDirectional.only(bottom: 10),
            width: SizeConfig.screenWidth * 0.8,

            color: Colors.white,
            child: GridView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,

              padding:
                  const EdgeInsets.only(right: 5, left: 5, bottom: 15),
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
              children: [


                MainOrderCard(
                  image: 'images/cat1.png',
                  category: 'كتب جامعية',
                  backgroudItem: Color(0XFFFFF3C7),
                ),
                MainOrderCard(
                  image: 'images/cat2.png',
                  category: 'المرحلة الثانوية',
                  backgroudItem: Color(0XFFFFE3F6),
                ),
                MainOrderCard(
                  image: 'images/cat3.png',
                  category: 'المرحلة الإعدادية',
                  backgroudItem: Color(0XFFC6FAFF),
                ),
                MainOrderCard(
                  image: 'images/cat4.png',
                  category: 'المرحلة الابتدائية',
                  backgroudItem: Color(0XFFCEE0FF),
                ),
                MainOrderCard(
                  image: 'images/out1.png',
                  category: 'رياض الأطفال',
                  backgroudItem: Color(0XFFCEE0FF),
                ),
                MainOrderCard(
                  image: 'images/out2.png',
                  category: 'التصميم',
                  backgroudItem: Color(0XFFFFE3F6),
                ),

              ],
            ),
          ),
        ],

      ),
    );
  }

  void onProductCardTapped(String productId) {}
}
