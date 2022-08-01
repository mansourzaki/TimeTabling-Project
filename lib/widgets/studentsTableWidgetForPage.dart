import 'package:flutter/material.dart';
import 'package:timetabling/models/output_subject_state.dart';

import 'package:timetabling/models/subject.dart';
import 'package:timetabling/screens/departments_screen.dart';
import 'package:timetabling/shared/constants.dart';
import 'package:provider/provider.dart';
import '../services/pdf_api.dart';

class StudentsTimeTableForPage extends StatelessWidget {
  final List<Subject> allsubjects;
  final String level;
  final Department department;
  final bool isMale;
  const StudentsTimeTableForPage(
      {Key? key,
      required this.allsubjects,
      required this.level,
      required this.isMale,
      required this.department})
      : super(key: key);

  List<Subject> filerSubjects(List<Subject> allSubjectss) {
    List<Subject> subjects = allSubjectss
        .where((element) => element.department.contains(department))
        .toList();
    return subjects;
  }

  int getNumOfGroups() {
    List groups = [];
    List<Subject> subjects = allsubjects
        .where((element) => element.department.contains(department))
        .toList();
    subjects.forEach((e) {
      groups.add(e.group);
    });
    return groups.toSet().length;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OutputSubjectsState>(context);
    return allsubjects.isEmpty
        ? Center(
            child: Text('No Data'),
          )
        : _studentsTimeTableWidget(
            allsubjects: allsubjects,
            level: level,
            department: department,
            isMale: isMale);
  }
}

Widget _studentsTimeTableWidget(
    {required List<Subject> allsubjects,
    required String level,
    required bool isMale,
    required Department department}) {
  List<Subject> subjects = allsubjects
      .where((element) => element.department.contains(department))
      .toList();
  print('len dep ${department}');
  print('len dep ${subjects.length}');
  bool isPractical = false;
  List<String> allGroups = [];
  Set<String> pGroups = {};
  Set<String> vGroups = {};
  subjects.forEach((e) {
    allGroups.add(e.group);
  });

  List<Subject> pSubss =
      subjects.where((element) => element.type == Types.P).toList();
  List<Subject> vSubss =
      subjects.where((element) => element.type == Types.V).toList();
  print('lenP ${pSubss.length}');
  print('lenV ${vSubss.length}');

  pSubss.forEach((element) {
    pGroups.add(element.group);
  });
  vSubss.forEach((element) {
    vGroups.add(element.group);
  });

  print('subs ${vGroups.toString()}');
  print('subs ${pGroups.toString()}');
  print(department.toString().split('.').last);

  // allGroups.forEach((element) {
  //   String dep = department.toString().split('.').last;
  //   String practicalGroups = '$dep $allsubjects';
  //   String forGroup = department.toString();
  //   groupsTabels.add(subjects.where((e) {
  //     if (e.forGroup != null) {
  //       return e.group == element || e.forGroup!.contains(forGroup);
  //     } else {
  //       return false;
  //     }
  //   }).toList());
  // });
  print(subjects.toString());
  String dep = department.toString().split('.').last;
  subjects.forEach((element) {
    if (element.forGroup == null) {
      isPractical = true;
    }
  });
  return ListView.builder(
    physics: ClampingScrollPhysics(),
    shrinkWrap: true,
    scrollDirection: Axis.vertical,
    itemCount: isPractical ? vGroups.length : pGroups.length,
    itemBuilder: (context, i) {
      print('groupV ${vGroups.length} ${pGroups.toString()}');
      print('tesst ${allGroups[i]}');

      if (isPractical) {
        List<Subject> newSubject = vSubss.where((element) {
          return element.group == allGroups.toSet().elementAt(i);
        }).toList();
        print('i $i');
        List<Subject> restOfSubjects = isMale
            ? pSubss
                .where((element) => element.forGroup!
                    .contains(i >= 9 ? '$dep 1${i + 1}' : '$dep 10${i + 1}'))
                .toList()
            : pSubss
                .where((element) => element.forGroup!
                    .contains(i > 9 ? '$dep 2${i + 1}' : '$dep 20${i + 1}'))
                .toList();
        newSubject.addAll(restOfSubjects);
        newSubject = newSubject.reversed.toList();
        print('object');
        return _buildTable(
            isPractical ? newSubject : subjects, 'Group ${i + 1}');
      } else {
        List<Subject> newSubject = pSubss.where((element) {
          return element.group == allGroups.toSet().elementAt(i);
        }).toList();
        print('depp $dep');
        List<Subject> restOfSubjects = isMale
            ? pSubss
                .where(
                    (element) => element.forGroup!.contains('$dep 10${i + 1}'))
                .toList()
            : pSubss
                .where(
                    (element) => element.forGroup!.contains('$dep 20${i + 1}'))
                .toList();
        newSubject.addAll(restOfSubjects);
        newSubject = newSubject.reversed.toSet().toList();
        print('object');
        return _buildTable(newSubject, 'Group ${i + 1}');
      }
    },
  );
}

Widget _buildTable(List<Subject> subjects, String groupName) {
  return SingleChildScrollView(
    child: Column(children: [
      Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 10),
        child: Center(
          child: Text(
            groupName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      DataTable(
        dataRowColor: MaterialStateProperty.all(Colors.white),
        headingRowColor: MaterialStateProperty.all(Colors.white),
        headingTextStyle: TextStyle(color: Colors.black),
        dataTextStyle: TextStyle(color: Colors.black),
        columnSpacing: 5,
        border: TableBorder.all(),
        columns: [
          DataColumn(
            label: Text("Subject"),
          ),
          DataColumn(
            label: Text("Lecturer Name"),
          ),
          DataColumn(
            label: Text("Group"),
          ),
          DataColumn(
            label: Text("ClassRoom"),
          ),
          DataColumn(label: Text(saturday)),
          DataColumn(label: Text(sunday)),
          DataColumn(label: Text(monday)),
          DataColumn(label: Text(tuesday)),
          DataColumn(label: Text(wednesday)),
        ],
        rows: List.generate(subjects.length, (i) {
          return DataRow(
              color: i % 2 == 0
                  ? MaterialStateProperty.all(Colors.grey[300])
                  : MaterialStateProperty.all(Colors.white),
              cells: [
                DataCell(SizedBox(
                  width: 300,
                  child: Text(
                    subjects[i].subject,
                    softWrap: true,
                    overflow: TextOverflow.clip,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                )),
                DataCell(SizedBox(
                  width: 200,
                  child: Text(
                    subjects[i].lecturer.toString(),
                    softWrap: true,
                    overflow: TextOverflow.fade,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                )),
                DataCell(SizedBox(
                  width: 100,
                  child: Text(
                    subjects[i].group.toString(),
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                )),
                DataCell(SizedBox(
                  width: 100,
                  child: Text(
                    subjects[i].assignedClassroom.toString(),
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                )),
                //Saturday
                DataCell(SizedBox(
                  width: 100,
                  child: Text(
                    subjects[i].daysNum() == 33 || subjects[i].daysNum() == 1
                        ? subjects[i].getTime
                        : '',
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                )),
                //Sunday
                DataCell(SizedBox(
                  width: 100,
                  child: Text(
                    subjects[i].daysNum() == 22 || subjects[i].daysNum() == 2
                        ? subjects[i].getTime
                        : '',
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                )),
                //Monday
                DataCell(SizedBox(
                  width: 100,
                  child: Text(
                    subjects[i].daysNum() == 33 || subjects[i].daysNum() == 3
                        ? subjects[i].getTime
                        : '',
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                )),
                //Tuesday
                DataCell(SizedBox(
                  width: 100,
                  child: Text(
                    subjects[i].daysNum() == 22 || subjects[i].daysNum() == 4
                        ? subjects[i].getTime
                        : '',
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                )),
                //Wednesday
                DataCell(SizedBox(
                  width: 100,
                  child: Text(
                    subjects[i].daysNum() == 33 || subjects[i].daysNum() == 5
                        ? subjects[i].getTime
                        : '',
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                )),
                // DataCell(SizedBox(
                //   width: 100,
                //   child: Text(
                //     e.daysNum() == 33 || e.daysNum() == 5 ? e.getTime : '',
                //     softWrap: true,
                //     overflow: TextOverflow.ellipsis,
                //     style: const TextStyle(fontWeight: FontWeight.w600),
                //   ),
                // )),
              ]);
        }),
      ),
      const SizedBox(
        height: 20,
      )
    ]),
  );
}
