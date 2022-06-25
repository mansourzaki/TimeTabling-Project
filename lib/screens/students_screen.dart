import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:timetabling/models/output_subject_state.dart';
import 'package:timetabling/models/subject.dart';
import 'departments_screen.dart';

class StudentsScreen extends StatelessWidget {
//final OutputSubjectsState provider;
  final List<Subject> allSubjects;
  const StudentsScreen({Key? key, required this.allSubjects}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //List<Subject> allSubjects = provider.allSubjects;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Level'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Level 1'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => DepartmentsScreen(
                        level: '1',
                        allSubjects: allSubjects,
                      ))));
            },
          ),
          ListTile(
            title: const Text('Level 2'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => DepartmentsScreen(
                        level: '2',
                        allSubjects: allSubjects,
                      ))));
            },
          ),
          ListTile(
            title: const Text('Level 3'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => DepartmentsScreen(
                        level: '3',
                        allSubjects: allSubjects,
                      ))));
            },
          ),
          ListTile(
            title: const Text('Level 4'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => DepartmentsScreen(
                        level: '4',
                        allSubjects: allSubjects,
                      ))));
            },
          ),
        ],
      ),
    );
  }
}
