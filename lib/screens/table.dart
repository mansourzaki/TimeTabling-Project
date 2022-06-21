


import 'package:flutter/material.dart';
import '../models/classes.dart';
import '../models/classrooms.dart';
class StudentsTable extends StatefulWidget {
  final List<Classes> allClasses;
  const StudentsTable({Key? key, required this.allClasses}) : super(key: key);

  @override
  State<StudentsTable> createState() => _StudentsTableState();
}

class _StudentsTableState extends State<StudentsTable> {
  // List<Classes> allClasses = [];
  Classrooms? classrooms;
  List headers = [
    {'title': 'Name', 'index': 1, 'key': 'Subject'},
    {'title': 'Type', 'index': 2, 'key': 'Type'},
    {'title': 'Level', 'index': 3, 'key': 'Level'},
    {'title': 'Department', 'index': 4, 'key': 'for'},
    {'title': 'Lecturer', 'index': 4, 'key': 'Lecturer'},
    {'title': 'Group', 'index': 4, 'key': 'Group'},
    {'title': 'Classroom', 'index': 4, 'key': 'Classroom'},
    {'title': 'Duration', 'index': 4, 'key': 'Duration'},
  ];

  Future<List<Classes>> getClasses() async {
    return widget.allClasses;
  }

 

  @override
  Widget build(BuildContext context) {
    return widget.allClasses.isEmpty
        ? const Center(child: Text('Getting Data.....'))
        : SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DataTable(
                    border: TableBorder.all(),
                    columns: const [
                      DataColumn(
                        label: Text("Name"),
                      ),
                      DataColumn(
                        label: Text("Type"),
                      ),
                      DataColumn(
                        label: Text("Level"),
                      ),
                      DataColumn(
                        label: Text("Department"),
                      ),
                      DataColumn(
                        label: Text("Lecturer"),
                      ),
                      DataColumn(
                        label: Text("ClassRoom"),
                      ),
                      DataColumn(
                        label: Text("Group"),
                      ),
                      DataColumn(
                        label: Text("Duration"),
                      ),
                    ],
                    rows: widget.allClasses
                        .map((e) => DataRow(cells: [
                              _buildDataCell(e.subject, width: 150),
                              _buildDataCell(e.getType().toString()),
                              _buildDataCell(e.level.toString()),
                              _buildDataCell(e.getDepartment().toString()),
                              _buildDataCell(e.lecturer.toString(), width: 150),
                              _buildDataCell(e.group.toString()),
                              _buildDataCell(e.classroom),
                              _buildDataCell(e.duration.toString()),
                            ]))
                        .toList())),
          );
  }

  List<dynamic> getAllRows() {
    List rows = [];
    widget.allClasses.forEach((element) {
      rows.add(element.toJson());
    });
    return rows;
    // return filtered.map((e) => e.toJson());
  }
}

DataCell _buildDataCell(String text, {double width = 50}) {
  return DataCell(Container(
    width: width,
    child: Text(
      text,
      softWrap: true,
      overflow: TextOverflow.visible,
      style: const TextStyle(fontWeight: FontWeight.w600),
    ),
  ));
}
