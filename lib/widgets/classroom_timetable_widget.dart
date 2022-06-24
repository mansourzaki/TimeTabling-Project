import 'package:flutter/material.dart';

import 'package:timetabling/models/subject.dart';
import 'package:timetabling/shared/constants.dart';

class ClassRoomsTimeTable extends StatelessWidget {
  final List<Subject> allsubjects;
  final String classroom;
  const ClassRoomsTimeTable(
      {Key? key, required this.allsubjects, required this.classroom})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$classroom')),
      body: _classRoomsTimeTableWidget(
          allsubjects: allsubjects, classroom: classroom),
    );
  }
}

Widget _classRoomsTimeTableWidget(
    {required List<Subject> allsubjects, required String classroom}) {
  print('gettting');
  print('$classroom gettting');

  List<Subject> subjects = allsubjects
      .where(
        (e) => e.assignedClassroom == classroom,
      )
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
