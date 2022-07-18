import 'package:flutter/material.dart';

import '../../../common/responsive.dart';
import '../../../utile/constants.dart';
import 'components/header.dart';

import 'components/my_fields.dart';
import 'components/recent_files.dart';
import 'components/storage_details.dart';

class DashboardScreenAdmin extends StatelessWidget {
  static const routeName = '/DashboardScreenAdmin';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(right: 16.0,left: 16),
            child: Column(
              children: [
                Header(),
                SizedBox(height: defaultPadding),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                        children: [
                          MyFiles(),
                          SizedBox(height: defaultPadding),
                          RecentFiles(),
                          if (Responsive.isMobile(context))
                            SizedBox(height: defaultPadding),
                          if (Responsive.isMobile(context)) StarageDetails(),
                        ],
                      ),
                    ),
                    if (!Responsive.isMobile(context))
                      SizedBox(width: defaultPadding),
                    // On Mobile means if the screen is less than 850 we dont want to show it
                    if (!Responsive.isMobile(context))
                      Expanded(
                        flex: 2,
                        child: StarageDetails(),
                      ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
