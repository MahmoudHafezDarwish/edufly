import 'package:edufly/gen/assets.gen.dart';
import 'package:edufly/utile/constants.dart';
import 'package:flutter/material.dart';

class CloudStorageInfo {
  final String? svgSrc, title, totalStorage;
  final int? numOfFiles, percentage;
  final Color? color;

  CloudStorageInfo({
    this.svgSrc,
    this.title,
    this.totalStorage,
    this.numOfFiles,
    this.percentage,
    this.color,
  });
}

List demoMyFiles = [
  CloudStorageInfo(
    title: "عدد المصممين",
    numOfFiles: 1328,
    svgSrc: Assets.icons.documents,
    totalStorage: " 100 مصمم",
    color: kPrimaryColor,
    percentage: 35,
  ),
  CloudStorageInfo(
    title: "عدد الزبائن",
    numOfFiles: 1328,
    svgSrc: Assets.icons.googleDrive,
    totalStorage: "500 زبون",
    color: Color(0xFF9CA5B8),
    percentage: 35,
  ),
  CloudStorageInfo(
    title: "إجمالي المبيعات",
    numOfFiles: 1328,
    svgSrc: Assets.icons.oneDrive,
    totalStorage: "1500 ر.س",
    color: Color(0xFF222248),
    percentage: 10,
  ),
  CloudStorageInfo(
    title: "صافي الربح",
    numOfFiles: 5328,
    svgSrc: Assets.icons.dropBox,
    totalStorage: "500 ر.س",
    color: Color(0xFF1A13DA),
    percentage: 78,
  ),
];
