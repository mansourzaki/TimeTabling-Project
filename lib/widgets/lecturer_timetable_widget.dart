import 'package:flutter/material.dart';
import 'package:timetabling/models/output_subject_state.dart';

import 'package:timetabling/models/subject.dart';
import 'package:timetabling/shared/constants.dart';
import 'package:provider/provider.dart';
import '../services/pdf_api.dart';

class LecturersTimeTable extends StatelessWidget {
  final String lecturer;
  const LecturersTimeTable({Key? key, required this.lecturer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<OutputSubjectsState>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('$lecturer'),
        actions: [
          IconButton(
              onPressed: () async {
                List<Subject> subjects = _provider.allSubjects
                    .where((e) => e.lecturer == lecturer)
                    .toList();

                // final pdfFile =
                try {
                  //await PdfApi.generateTable(subjects);
                } catch (e) {
                  print(e);
                }

                //PdfApi.openFile(pdfFile);
              },
              icon: Icon(Icons.download))
        ],
      ),
      body: _LecturersTimeTableWidget(
          allsubjects: _provider.allSubjects, lecturer: lecturer),
    );
  }
}

Widget _LecturersTimeTableWidget(
    {required List<Subject> allsubjects, required String lecturer}) {
  print('gettting');
  print('$lecturer gettting');

  List<Subject> subjects = allsubjects
      .where(
        (e) => e.lecturer.contains(lecturer),
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
