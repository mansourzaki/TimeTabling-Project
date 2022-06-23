import 'package:flutter/material.dart';

import 'package:timetabling/models/subject.dart';

class ClassroomsTableScreen extends StatefulWidget {
  const ClassroomsTableScreen(
      {Key? key, required this.name, required this.allSubjects})
      : super(key: key);
  final String name;
  final List<Subject> allSubjects;
  @override
  State<ClassroomsTableScreen> createState() => _ClassroomsTableScreenState();
}

class _ClassroomsTableScreenState extends State<ClassroomsTableScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.name} Tabel')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DataTable(
                border: TableBorder.all(),
                columns: const [
                  DataColumn(
                    label: Text("Subject"),
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
                  DataColumn(label: Text('Time')),
                ],
                rows: widget.allSubjects
                    .where(
                        (element) => element.assignedClassroom == widget.name)
                    .map(
                      (e) => DataRow(cells: [
                        DataCell(SizedBox(
                          width: 300,
                          child: Text(
                            e.subject,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        )),
                        DataCell(SizedBox(
                          width: 200,
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
                            e.assignedClassroom,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        )),
                        DataCell(SizedBox(
                          width: 200,
                          child: Text(
                            e.getDays.toString(),
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        )),
                        DataCell(SizedBox(
                          width: 100,
                          child: Text(
                            e.getTime,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        )),
                      ]),
                    )
                    .toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
