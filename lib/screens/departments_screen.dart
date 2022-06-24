import 'package:flutter/material.dart';
import 'package:timetabling/models/subject.dart';
import 'package:timetabling/screens/gender_screen.dart';


class DepartmentsScreen extends StatelessWidget {
  final String level;
  final List<Subject> allSubjects;
  const DepartmentsScreen(
      {Key? key, required this.level, required this.allSubjects})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            title: const Text('General'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => GenderScreen(
                      allSubjects: allSubjects,
                      department: Department.G,
                      level: level))));
            },
          ),
          ListTile(
            title: const Text('Computer Science'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => GenderScreen(
                      allSubjects: allSubjects,
                      department: Department.CS,
                      level: level))));
            },
          ),
          ListTile(
            title: const Text('Software Development'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => GenderScreen(
                      allSubjects: allSubjects,
                      department: Department.SD,
                      level: level))));
            },
          ),
          ListTile(
            title: const Text('Informaton Technology'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => GenderScreen(
                      allSubjects: allSubjects,
                      department: Department.IT,
                      level: level))));
            },
          ),
          ListTile(
            title: const Text('Multi Media'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => GenderScreen(
                      allSubjects: allSubjects,
                      department: Department.MM,
                      level: level))));
            },
          ),
          ListTile(
            title: const Text('Mobile'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => GenderScreen(
                      allSubjects: allSubjects,
                      department: Department.MO,
                      level: level))));
            },
          ),
        ],
      ),
    );
  }
}
