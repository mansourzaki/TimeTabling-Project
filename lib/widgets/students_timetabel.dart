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
                  await PdfApi.generateTable(
                      provider.getSubjects(department)[1]);
                  await PdfApi.generateTable(
                      provider.getSubjects(department)[2]);
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
  List<String> groups = [];
  subjects.forEach((e) {
    groups.add(e.group);
  });
  print('ff');

  print('tesst $groups');
  print('tesst groups ${groups.toSet()}');

  List<List<Subject>> groupsTabels = [];
  return ListView.builder(
    scrollDirection: Axis.vertical,
    itemCount: groups.toSet().length,
    itemBuilder: (context, i) {
      print('tesst ${groups[i]}');
       
      return _buildTable(
          subjects.where((element) => element.group == groups.toSet().elementAt(i)).toList(),
          'Group ${i + 1}');
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
