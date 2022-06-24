import 'package:flutter/material.dart';
import 'package:timetabling/widgets/students_timetabel.dart';

import '../models/subject.dart';

class GenderScreen extends StatelessWidget {
  final List<Subject> allSubjects;
  final String level;
  final Department department;
  const GenderScreen(
      {Key? key,
      required this.allSubjects,
      required this.department,
      required this.level})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            title: const Text('Male'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => StudentsTimeTable(
                      allsubjects: allSubjects,
                      level: level,
                      isMale: true,
                      department: department))));
            },
          ),
          ListTile(
            title: const Text('Female'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => StudentsTimeTable(
                      allsubjects: allSubjects,
                      level: level,
                      isMale: false,
                      department: department))));
            },
          ),
        ],
      ),
    );
  }
}
