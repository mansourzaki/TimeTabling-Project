import 'package:flutter/material.dart';
import 'package:timetabling/models/subject.dart';
import 'package:timetabling/screens/gender_screen.dart';
import 'package:timetabling/widgets/students_timetabel.dart';

class DepartmentsScreen extends StatelessWidget {
  final String level;
  final List<Subject> allSubjects;
  final bool isMale;
  const DepartmentsScreen(
      {Key? key,
      required this.level,
      required this.allSubjects,
      required this.isMale})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Department'),
      ),
      body: level == '1'
          ? ListTile(
              title: isMale ? Text('General Male') : Text('General Female'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => StudentsTimeTable(
                          allsubjects: allSubjects,
                          level: level,
                          department: isMale ? Department.Gm : Department.Gf,
                          isMale: isMale,
                        ))));
              },
            )
          : ListView(
              children: [
                ListTile(
                  title: isMale ? Text('General Male') : Text('General Female'),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => StudentsTimeTable(
                              allsubjects: allSubjects,
                              level: level,
                              department:
                                  isMale ? Department.Gm : Department.Gf,
                              isMale: isMale,
                            ))));
                  },
                ),
                ListTile(
                  title: isMale
                      ? Text('Computer Science $level Male')
                      : Text('Computer Science $level Female'),
                  onTap: () {
                    String x = "Department.CS_$level";
                    String gender = isMale ? "m" : "f";
                    Department department = Department.values.firstWhere(
                        (element) => element.toString() == x + gender);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => StudentsTimeTable(
                            isMale: isMale,
                            allsubjects: allSubjects,
                            department: department,
                            level: level))));
                  },
                ),
                ListTile(
                  title: isMale
                      ? Text('Software Development $level Male')
                      : Text('Software Development $level Female'),
                  onTap: () {
                    String x = "Department.SD_$level";
                    String gender = isMale ? "m" : "f";
                    Department department = Department.values.firstWhere(
                        (element) => element.toString() == x + gender);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => StudentsTimeTable(
                            isMale: isMale,
                            allsubjects: allSubjects,
                            department: department,
                            level: level))));
                  },
                ),
                ListTile(
                  title: isMale
                      ? Text('Informaton Technology $level Male')
                      : Text('Informaton Technology $level Femal'),
                  onTap: () {
                    String x = "Department.IT_$level";
                    String gender = isMale ? "m" : "f";
                    Department department = Department.values.firstWhere(
                        (element) => element.toString() == x + gender);
                    print(department);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => StudentsTimeTable(
                            allsubjects: allSubjects,
                            isMale: isMale,
                            department: department,
                            level: level))));
                  },
                ),
                ListTile(
                  title: isMale
                      ? Text('Multi Media $level Male')
                      : Text('Multi Media $level Female'),
                  onTap: () {
                    String x = "Department.MM_$level";
                    String gender = isMale ? "m" : "f";
                    Department department = Department.values.firstWhere(
                        (element) => element.toString() == x + gender);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => StudentsTimeTable(
                            allsubjects: allSubjects,
                            department: department,
                            isMale: isMale,
                            level: level))));
                  },
                ),
                ListTile(
                  title: isMale
                      ? Text('Mobile $level Male')
                      : Text('Mobile $level Female'),
                  onTap: () {
                    String x = "Department.MO_$level";
                    String gender = isMale ? "m" : "f";
                    Department department = Department.values.firstWhere(
                        (element) => element.toString() == x + gender);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => StudentsTimeTable(
                            allsubjects: allSubjects,
                            isMale: isMale,
                            level: level,
                            department: department))));
                  },
                ),
              ],
            ),
    );
  }
}
