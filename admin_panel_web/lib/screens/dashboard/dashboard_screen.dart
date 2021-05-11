import 'package:admin_panel_web/constants.dart';
import 'package:admin_panel_web/models/RecentFile.dart';
import 'package:admin_panel_web/responsive.dart';
import 'package:admin_panel_web/screens/dashboard/components/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'components/my_field.dart';
import 'components/storage_details.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Header(),
              SizedBox(
                height: defaultPadding,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        MyField(),
                        SizedBox(
                          height: defaultPadding,
                        ),
                        Container(
                          padding: EdgeInsets.all(defaultPadding),
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Recent Files",
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: DataTable(
                                  horizontalMargin: 0,
                                  columnSpacing: defaultPadding,
                                  columns: [
                                    DataColumn(label: Text("File Name")),
                                    DataColumn(label: Text("Date")),
                                    DataColumn(label: Text("Size")),
                                  ],
                                  rows: List.generate(
                                    demoRecentFiles.length,
                                    (index) => recentFileDataRow(
                                        demoRecentFiles[index]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (Responsive.isMobile(context))
                          SizedBox(
                            height: defaultPadding,
                          ),
                        if (Responsive.isMobile(context)) StorageDetails(),
                      ],
                    ),
                  ),
                  if (!Responsive.isMobile(context))
                    SizedBox(
                      width: defaultPadding,
                    ),
                  if (!Responsive.isMobile(context))
                    Expanded(
                      flex: 2,
                      child: StorageDetails(),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  DataRow recentFileDataRow(RecentFile fileInfo) {
    return DataRow(
      cells: [
        DataCell(
          Row(
            children: [
              SvgPicture.asset(
                fileInfo.icon,
                height: 30,
                width: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Text(fileInfo.title),
              ),
            ],
          ),
        ),
        DataCell(Text(fileInfo.date)),
        DataCell(Text(fileInfo.size)),
      ],
    );
  }
}
