import 'package:flutter/material.dart';
import 'package:timetabling/screens/pages/lecturers_page.dart';
import 'package:timetabling/widgets/header.dart';

import '../constants.dart';

class DashboardScreen extends StatelessWidget {
  List<Widget> pages = [
    LectuturersPage(),
  ];
  void fun(String x) {}
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(search: fun),
            SizedBox(
              height: 20,
            ),
            LectuturersPage()
            //Filters,
            //SizedBox(height: defaultPadding),
            // DataTabels,
            //  if (Responsive.isMobile(context))
            //   SizedBox(height: defaultPadding),
            //  if (Responsive.isMobile(context)) StarageDetails(),
          ],
        ),
      ),
    );
  }
}
