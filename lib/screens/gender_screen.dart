import 'package:flutter/material.dart';
import 'package:timetabling/widgets/students_timetabel.dart';

import '../models/subject.dart';
import 'departments_screen.dart';

class GenderScreen extends StatelessWidget {
  final List<Subject> allSubjects;
  final String level;
  const GenderScreen({
    Key? key,
    required this.allSubjects,
    required this.level,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Gender'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Male'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => DepartmentsScreen(
                        allSubjects: allSubjects,
                        level: level,
                        isMale: true,
                      ))));
            },
          ),
          ListTile(
            title: const Text('Female'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => DepartmentsScreen(
                        allSubjects: allSubjects,
                        level: level,
                        isMale: false,
                      ))));
            },
          ),
        ],
      ),
    );
  }
}
