
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImagSlider extends StatefulWidget {
  const ImagSlider({Key? key}) : super(key: key);

  @override
  _ImagSliderState createState() => _ImagSliderState();
}

class _ImagSliderState extends State<ImagSlider> {
  final List<String> imgList = ['images/cat1.png','images/cat2.png','images/cat3.png',];


  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Container(
            child: CarouselSlider.builder(
              itemCount: imgList.length,
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
              ),
              itemBuilder: (context, index, realIdx) {
                return Container(
                  child: Center(
                      child: Image.asset(imgList[index],
                          fit: BoxFit.contain, width: 1000,height: 1000,)),
                );
              },
            )),
      ],
    );
    // return Column(
    //   children: [
    //    FutureBuilder(
    //        future: getImgSliderDb(),
    //
    //        builder: (_,AsyncSnapshot snapshot){
    //          if(snapshot.data!=null){
    //            return CarouselSlider.builder(itemCount: snapshot.data!.length,
    //                itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex){
    //                  DocumentSnapshot imagSlider=snapshot.data[itemIndex];
    //                  Object? getImag= imagSlider.data();
    //                  return SizedBox(
    //                    width: MediaQuery.of(context).size.width,
    //                    child: Image.network((getImag as dynamic)['imag'],
    //                      fit: BoxFit.fill,),
    //                  );
    //
    //            }, options: CarouselOptions(
    //                height: 150,
    //
    //                viewportFraction: 1,
    //                initialPage: 0,
    //                autoPlay: true,
    //                autoPlayCurve: Curves.fastOutSlowIn,
    //              ),);
    //          }else{ return Container(
    //            color: Colors.orange,
    //          );}
    //        })
    //
    //   ],
    // );
  }
}
