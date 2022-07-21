import 'package:flutter/material.dart';

import 'package:timetabling/models/output_subject_state.dart';
import 'package:timetabling/screens/choosLecturer_screen.dart';
import 'package:timetabling/screens/classrooms_screen.dart';
import 'package:timetabling/screens/dataScreen.dart';
import 'package:timetabling/screens/algorithim_screen.dart';
import 'package:timetabling/screens/lecturers_screen.dart';
import 'package:timetabling/screens/students_screen.dart';
import 'package:provider/provider.dart';
import '../models/input_subject_state.dart';
import '../responsive.dart';
import '../widgets/sidemenu.dart';
import 'dashboard_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OutputSubjectsState>(context);
    return Scaffold(
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SideMenu(),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: DashboardScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
