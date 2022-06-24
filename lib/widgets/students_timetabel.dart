import 'package:flutter/material.dart';

import 'package:timetabling/models/subject.dart';
import 'package:timetabling/shared/constants.dart';

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

  List<Subject> filterSubjects(List<Subject> allSubjectss) {
    List<Subject> subjects = isMale
        ? allSubjectss
            .where((e) =>
                e.level == level &&
                e.department.contains(department) &&
                e.group[0][0] == '1')
            .toList()
        : allSubjectss
            .where((e) =>
                e.level == level &&
                e.department.contains(department) &&
                e.group[0][0] == '2')
            .toList();
    return subjects;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tabel of level $level $department Department'),
        actions: [
          IconButton(
              onPressed: () async {
                List<Subject> subjects = isMale
                    ? allsubjects
                        .where((e) =>
                            e.level == level &&
                            e.department.contains(department) &&
                            e.group[0][0] == '1')
                        .toList()
                    : allsubjects
                        .where((e) =>
                            e.level == level &&
                            e.department.contains(department) &&
                            e.group[0][0] == '2')
                        .toList();
                final pdfFile = await PdfApi.generateTable(subjects);

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
  List<Subject> subjects = isMale
      ? allsubjects
          .where((e) =>
              e.level == level &&
              e.department.contains(department) &&
              e.group[0][0] == '1')
          .toList()
      : allsubjects
          .where((e) =>
              e.level == level &&
              e.department.contains(department) &&
              e.group[0][0] == '2')
          .toList();

  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: DataTable(
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
    ),
  );
}
