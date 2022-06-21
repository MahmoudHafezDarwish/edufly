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
              fontWeight: FontWeight.w500,
              fontFamily: fontFamilayTajawal,
            ),
          ),
          SizedBox(height: defaultPadding),
          Chart(),
          StorageInfoCard(
            svgSrc: Assets.icons.documents,
            title: "الطلبات الكلية",
            amountOfFiles: "500",
            numOfFiles: 500,
          ),
          StorageInfoCard(
            svgSrc: Assets.icons.documents,
            title: "الطلبات المقبولة",
            amountOfFiles: "250",
            numOfFiles: 250,
          ),
          StorageInfoCard(
            svgSrc: Assets.icons.documents,
            title: "الطلبات المعلقة",
            amountOfFiles: "500",
            numOfFiles: 100,
          ),
          StorageInfoCard(
            svgSrc: Assets.icons.documents,
            title: "الطلبات المرفوضة",
            amountOfFiles: "500",
            numOfFiles: 150,
          ),
        ],
      ),
    );
  }
}
