import 'package:edufly/gen/assets.gen.dart';
import 'package:flutter/material.dart';

import '../../../../utile/constants.dart';
import 'chart.dart';
import 'storage_info_card.dart';

class StarageDetails extends StatelessWidget {
  const StarageDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: kPrimaryDarkColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "تفاصيل الطلبات",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: kPrimaryColor,
              fontFamily: fontFamilayTajawal,
            ),
          ),
          SizedBox(height: defaultPadding),
          Chart(),
          StorageInfoCard(
            svgSrc: Assets.icons.documents,
            title: "عدد الطلبات الكلية",
            amountOfFiles: "500",
            numOfFiles: 500,
            color: kPrimaryColor.withOpacity(0.5),
            
          ),
          StorageInfoCard(
            svgSrc: Assets.icons.documents,
            title: "الطلبات المقبولة",
            amountOfFiles: "250",
            numOfFiles: 250,
            color: kPrimaryColor,
          ),
          StorageInfoCard(
            svgSrc: Assets.icons.documents,
            title: "الطلبات المعلقة",
            amountOfFiles: "500",
            numOfFiles: 100,
            color: Color(0xFFFFCF26),
          ),
          StorageInfoCard(
            svgSrc: Assets.icons.documents,
            title: "الطلبات المرفوضة",
            amountOfFiles: "500",
            numOfFiles: 150,
            color: Color(0xFFEE2727),
          ),
        ],
      ),
    );
  }
}
