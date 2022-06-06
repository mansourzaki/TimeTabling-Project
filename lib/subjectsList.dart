import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timetabling/models/subject.dart';

class SubjectsList extends StatefulWidget {
  const SubjectsList({Key? key}) : super(key: key);

  @override
  State<SubjectsList> createState() => _SubjectsListState();
}

class _SubjectsListState extends State<SubjectsList> {
  List<Subject> allSubjects = [];
  List<DataRow> rows = [];
  @override
  void initState() {
    loadSubjects();
    super.initState();
  }

  Future loadSubjects() async {
    final jsonString = await rootBundle.loadString('assets/iug_output.json');
    setState(() {
      //print(jsonDecode(jsonString)[5]);
      //  var currntSubjects = Subject.fromJson();
      List<dynamic> subjectsList = jsonDecode(jsonString);

      allSubjects = subjectsList
          .map(
            (json) => Subject.fromJson(json),
          )
          .toList();
      // for (int i = 0; i <= 10; i++) {
      //   TableRow row = createTableRow(allSubjects[i]);
      //   rows.add(row);
      // }
      allSubjects.forEach(
        (element) {
          DataRow row = createDataRow(element);
          rows.add(row);
        },
      );
      // x
      //     .map(
      //       (json) => Subject.fromJson(json),
      //     )
      //     .toList();
      // print(currntSubjects);
      print('in load');
      // print(currntSubjects);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Testing Json File'),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.all(5),
              child: DataTable(
                border: TableBorder.all(),
                columns: const [
                  DataColumn(
                    label: Text("Subject"),
                  ),
                  DataColumn(
                    label: Text("Lecturer"),
                  ),
                  DataColumn(
                    label: Text("Groups"),
                  ),
                  DataColumn(
                    label: Text("Assigned Classes"),
                  ),
                  DataColumn(
                    label: Text("Days"),
                  ),
                  DataColumn(
                    label: Text("Duration"),
                  ),
                  DataColumn(
                    label: Text("Department"),
                  ),
                  DataColumn(label: Text('Time')),
                ],
                rows: rows,
              )),
        ));
  }

  // void insertRows() {
  //   rows.clear();
  //   rows.add(const TableRow(children: [
  //     Text("Subject"),
  //     Text("Lecturer"),
  //     Text("Groups"),
  //     Text("Assigned Classes"),
  //     Text("Days"),
  //     Text("Duration"),
  //     Text("Department"),
  //     Text('Time')
  //   ]));
  // }

  DataRow createDataRow(Subject subject) {
    return DataRow(cells: [
      DataCell(
        Text(subject.subject.toString()),
      ),
      DataCell(Text(subject.lecturer.toString())),
      DataCell(Text(subject.group.toString())),
      DataCell(
        Text(subject.assignedClassroom.toString()),
      ),
      DataCell(
        Text(subject.getDays.toString()),
      ),
      DataCell(
        Text(subject.duration.toString()),
      ),
      DataCell(
        Text(subject.department.toString()),
      ),
      DataCell(
        Text(subject.getTime),
      )
    ]);
  }

  ListView _buildListView() {
    return ListView.builder(
        itemCount: allSubjects.length,
        itemBuilder: (context, i) {
          // var x = allSubjects[i].assignedTime.runtimeType.toString();
          // var d = allSubjects.forEach((element) {
          //   print(element.assignedTime.runtimeType == int);
          // });
          // print('ddd ${d.first.subject}');
          return ListTile(
            trailing: Text(i.toString()),
            title: Text(allSubjects[i].subject),
            subtitle: Text(allSubjects[i].getDays.toString()),
          );
        });
  }
}
