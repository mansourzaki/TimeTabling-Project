import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';

import 'package:timetabling/models/output_subject_state.dart';
import 'package:timetabling/screens/choosLecturer_screen.dart';
import 'package:timetabling/screens/classrooms_screen.dart';
import 'package:timetabling/screens/dataScreen.dart';
import 'package:timetabling/screens/algorithim_screen.dart';
import 'package:timetabling/screens/lecturers_screen.dart';
import 'package:timetabling/screens/pages/add_classrooms.dart';
import 'package:timetabling/screens/pages/add_new_Lecturer.dart';
import 'package:timetabling/screens/pages/classrooms_page.dart';
import 'package:timetabling/screens/pages/edit_input.dart';
import 'package:timetabling/screens/pages/lecturers_page.dart';
import 'package:timetabling/screens/pages/select_lecturer_page.dart';
import 'package:timetabling/screens/pages/students_tables_page.dart';
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
  PageController page = PageController();

  @override
  Widget build(BuildContext context) {
     PageController page = context.read<InputSubjectsState>().page;
    final provider = Provider.of<OutputSubjectsState>(context);
    return Scaffold(
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SideMenu(
                showToggle: true,
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/images/it_logo.jpg',
                    height: 150,
                    width: 150,
                  ),
                ),
                style: SideMenuStyle(
                    displayMode: SideMenuDisplayMode.compact,
                    hoverColor: Colors.blue[100],
                    iconSize: 16,
                    selectedIconColor: Colors.white,
                    unselectedIconColor: Colors.white54,
                    selectedTitleTextStyle: TextStyle(color: Colors.white),
                    unselectedTitleTextStyle: TextStyle(color: Colors.white54)),
                items: [
                  SideMenuItem(
                      // Priority of item to show on SideMenu, lower value is displayed at the top
                      priority: 0,
                      title: "Classrooms Tables",
                      icon: Icon(
                        Icons.school,
                      ),
                      onTap: () => page.jumpToPage(0)),
                  SideMenuItem(
                    priority: 1,
                    title: 'Lecturers Tables',
                    onTap: () => page.jumpToPage(1),
                    icon: Icon(
                      Icons.assignment_ind,
                    ),
                  ),
                  SideMenuItem(
                    priority: 2,
                    title: 'Students',
                    badgeColor: Colors.white54,
                    onTap: () => page.jumpToPage(2),
                    icon: Icon(
                      Icons.group,
                    ),
                  ),
                  SideMenuItem(
                    priority: 3,
                    title: 'Edit Input',
                    badgeColor: Colors.white54,
                    onTap: () => page.jumpToPage(3),
                    icon: Icon(
                      Icons.edit,
                    ),
                  ),
                  SideMenuItem(
                    priority: 4,
                    title: 'Select Lecturers',
                    badgeColor: Colors.white54,
                    onTap: () => page.jumpToPage(4),
                    icon: Icon(
                      Icons.assignment_ind,
                    ),
                  ),
                  SideMenuItem(
                    priority: 5,
                    title: 'Add New Lecturer',
                    badgeColor: Colors.white54,
                    onTap: () => page.jumpToPage(5),
                    icon: Icon(
                      Icons.add,
                    ),
                  ),
                  SideMenuItem(
                    priority: 6,
                    title: 'Add Classrooms',
                    onTap: () => page.jumpToPage(6),
                    icon: Icon(
                      Icons.class_,
                    ),
                  ),
                ],
                controller: page),
            Expanded(
                child: PageView(
              controller: page,
              children: [
                ClassroomsPage(),
                LectuturersPage(),
                StudedntsTablesPage(),
                EditInputScreen(),
                SelectLectuerPage(),
                AddNewLecturerPage(),
                AddClassroomsScreen()
              ],
            )),
          ],
        ),
      ),
    );
  }
}
