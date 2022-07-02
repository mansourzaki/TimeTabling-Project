import 'package:flutter/material.dart';
import 'package:timetabling/models/output_subject_state.dart';

import 'package:timetabling/models/subject.dart';
import 'package:timetabling/screens/departments_screen.dart';
import 'package:timetabling/shared/constants.dart';
import 'package:provider/provider.dart';
import '../services/pdf_api.dart';

class StudentsTimeTable extends StatelessWidget {
  final List<Subject> allsubjects;
  final String level;
  final Department department;
  final bool isMale;
  const StudentsTimeTable(
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Tabel of level $level $department'),
        actions: [
          IconButton(
              onPressed: () async {
                // List<Subject> subjects = isMale
                //     ? allsubjects
                //         .where((e) =>
                //             e.level == level &&
                //             e.department.contains(department) &&
                //             e.group[0][0] == '1')
                //         .toList()
                //     : allsubjects
                //         .where((e) =>
                //             e.level == level &&
                //             e.department.contains(department) &&
                //             e.group[0][0] == '2')
                //         .toList();
                // final pdfFile =
                try {
                  await PdfApi.generateTable(
                      provider.getSubjects(department)[0]);
                } catch (e) {
                  print(e);
                }

                //PdfApi.openFile(pdfFile);
              },
              icon: Icon(Icons.download))
        ],
      ),
      body: _studentsTimeTableWidget(
          allsubjects: allsubjects,
          level: level,
          department: department,
          isMale: isMale),
    );
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
  print('len ${subjects.length}');
  List<String> allGroups = [];
  Set<String> pGroups = {};
  Set<String> vGroups = {};
  subjects.forEach((e) {
    allGroups.add(e.group);
  });
  //print('ff');

  // print('tesst $allGroups');
  // print('tesst groups ${allGroups.toSet()}');

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

  String dep = department.toString().split('.').last;
  return ListView.builder(
    scrollDirection: Axis.vertical,
    itemCount: vGroups.length,
    itemBuilder: (context, i) {
      print('groupV $vGroups ${pGroups.toString()}');
      print('tesst ${allGroups[i]}');

      List<Subject> newSubject = vSubss.where((element) {
        return element.group == allGroups.toSet().elementAt(i);
      }).toList();
      // isMale
      //    ?
      print('i $i');

      List<Subject> restOfSubjects = isMale
          ? pSubss
              .where((element) => element.forGroup!.contains('$dep 10${i + 1}'))
              .toList()
          : pSubss
              .where((element) => element.forGroup!.contains('$dep 20${i + 1}'))
              .toList();
      newSubject.addAll(restOfSubjects);
      newSubject = newSubject.reversed.toList();
      //  newSubject.addAll(pSubss
      //     .where((element) => element.forGroup!.contains('$dep 20$i')));
      // String dep = department.toString().split('.').last;
      // String group = '$dep 10$i';
      // print('group $group ${vSubss.length}');

      //try createing to lists one for practical and one for theory then merge them

      // newSubject.addAll(vSubss
      //     .where((element) =>
      //         element.group == )
      //     .toList());
      return _buildTable(newSubject, 'Group ${i + 1}');

      // return _buildTable(
      //     subjects
      //         .where(
      //             (element) => element.group == allGroups.toSet().elementAt(i))
      //         .toList(),
      //     'Group ${i + 1}');
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
        columnSpacing: 5,
        border: TableBorder.all(),
        columns: const [
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
        rows: subjects
            .map(
              (e) => DataRow(cells: [
                DataCell(SizedBox(
                  width: 300,
                  child: Text(
                    e.subject,
                    softWrap: true,
                    overflow: TextOverflow.clip,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                )),
                DataCell(SizedBox(
                  width: 200,
                  child: Text(
                    e.lecturer.toString(),
                    softWrap: true,
                    overflow: TextOverflow.fade,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                )),
                DataCell(SizedBox(
                  width: 100,
                  child: Text(
                    e.group.toString(),
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                )),
                DataCell(SizedBox(
                  width: 100,
                  child: Text(
                    e.assignedClassroom.toString(),
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                )),
                //Saturday
                DataCell(SizedBox(
                  width: 100,
                  child: Text(
                    e.daysNum() == 33 || e.daysNum() == 1 ? e.getTime : '',
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                )),
                //Sunday
                DataCell(SizedBox(
                  width: 100,
                  child: Text(
                    e.daysNum() == 22 || e.daysNum() == 2 ? e.getTime : '',
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                )),
                //Monday
                DataCell(SizedBox(
                  width: 100,
                  child: Text(
                    e.daysNum() == 33 || e.daysNum() == 3 ? e.getTime : '',
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                )),
                //Tuesday
                DataCell(SizedBox(
                  width: 100,
                  child: Text(
                    e.daysNum() == 22 || e.daysNum() == 4 ? e.getTime : '',
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                )),
                //Wednesday
                DataCell(SizedBox(
                  width: 100,
                  child: Text(
                    e.daysNum() == 33 || e.daysNum() == 5 ? e.getTime : '',
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                )),
              ]),
            )
            .toList(),
      ),
      const SizedBox(
        height: 20,
      )
    ]),
  );
}
