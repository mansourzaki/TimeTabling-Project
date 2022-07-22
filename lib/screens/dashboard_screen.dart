import 'package:flutter/material.dart';
import 'package:timetabling/models/navigation_state.dart';
import 'package:timetabling/screens/pages/classrooms_page.dart';
import 'package:timetabling/screens/pages/lecturers_page.dart';
import 'package:timetabling/screens/pages/students_tables_page.dart';
import 'package:timetabling/widgets/header.dart';
import 'package:provider/provider.dart';
import '../constants.dart';

class DashboardScreen extends StatelessWidget {
  List<Widget> pages = [
    ClassroomsPage(),
    LectuturersPage(),
  ];
  final PageController _controller = PageController();
  void fun(String x) {}
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NavigationScreenState>(context);
    return SafeArea(
      child: SingleChildScrollView(
          primary: false,
          padding: EdgeInsets.all(defaultPadding),
          child: SizedBox(
              width: 500,
              height: MediaQuery.of(context).size.height,
              child: pages[provider.index])),
    );
  }
}
