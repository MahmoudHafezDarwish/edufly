import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utile/constants.dart';
import '../../models/RecentFile.dart';

class RecentFiles extends StatelessWidget {
  const RecentFiles({
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
            "قبول المصممين",
            // style: Theme.of(context).textTheme.subtitle1,
            style: TextStyle(
                fontFamily: fontFamilayTajawal,
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
          SizedBox(
            width: 400,
            height: 300,
            child: DataTable2(
              columnSpacing: defaultPadding,

              minWidth: 400,

              columns: [

                DataColumn(
                  label: Text(
                    "اسم المصمم",
                    style: TextStyle(
                      fontFamily: fontFamilayTajawal,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "تاريخ الانضمام",
                    style: TextStyle(
                      fontFamily: fontFamilayTajawal,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "حالة الطلب",
                    style: TextStyle(
                      fontFamily: fontFamilayTajawal,
                    ),
                  ),
                ),
              ],
              rows: List.generate(
                demoRecentFiles.length,
                (index) => recentFileDataRow(demoRecentFiles[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow recentFileDataRow(RecentFile fileInfo) {
  return DataRow(
    cells: [
      DataCell(

        Row(
          // mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // SvgPicture.asset(
            //   fileInfo.icon!,
            //   height: 30,
            //   width: 30,
            // ),
            Padding(
              padding: const EdgeInsets
                  .symmetric(horizontal: defaultPadding),
              child: Text(fileInfo.title!),
            ),
          ],
        ),
      ),
      DataCell(Text(fileInfo.date!)),
      DataCell(Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            fileInfo.size!,
            style: TextStyle(fontFamily: fontFamilayTajawal),
          ),
          IconButton(
            onPressed: () {
              fileInfo.isAccept = (!fileInfo.isAccept!);
            },
            icon: Icon(
              fileInfo.isAccept! ? Icons.verified : Icons.remove_circle_outline,
              color: fileInfo.isAccept! ? kPrimaryColor : Colors.grey,
            ),
          ),
        ],
      )),
    ],
  );
}
