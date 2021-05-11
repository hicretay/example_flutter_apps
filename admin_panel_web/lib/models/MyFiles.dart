import 'package:flutter/material.dart';

import '../constants.dart';

class CloudStorageInfo {
  final String svgSrc, title, totalStorage;
  final int numOfFields, percentage;
  final Color color;

  CloudStorageInfo(
      {this.svgSrc,
      this.title,
      this.totalStorage,
      this.numOfFields,
      this.percentage,
      this.color});
}

List demoMyFields = [
  CloudStorageInfo(
    title: "Documents",
    numOfFields: 1328,
    svgSrc: "assets/icons/Documents.svg",
    totalStorage: "1.9GB",
    color: primaryColor,
    percentage: 35,
  ),
  CloudStorageInfo(
    title: "Google Drive",
    numOfFields: 1328,
    svgSrc: "assets/icons/google_drive.svg",
    totalStorage: "2.9GB",
    color: Color(0xFFFFA113),
    percentage: 35,
  ),
  CloudStorageInfo(
    title: "One Drive",
    numOfFields: 1328,
    svgSrc: "assets/icons/one_drive.svg",
    totalStorage: "1GB",
    color: Color(0xFFA4CDFF),
    percentage: 10,
  ),
  CloudStorageInfo(
    title: "Documents",
    numOfFields: 5328,
    svgSrc: "assets/icons/drop_box.svg",
    totalStorage: "7.3GB",
    color: Color(0xFF007EE5),
    percentage: 78,
  ),
];
