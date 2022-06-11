import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:timetabling/models/subject.dart';

class LecturereTableScreen extends StatefulWidget {
  const LecturereTableScreen(
      {Key? key, required this.lecturer, required this.allSubjects})
      : super(key: key);
  final String lecturer;
  final List<Subject> allSubjects;
  @override
  State<LecturereTableScreen> createState() => _LecturereTableScreenState();
}

class _LecturereTableScreenState extends State<LecturereTableScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.lecturer} Tabel')),
      body: Padding(
        padding: EdgeInsets.all(16),
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
                  .where((element) => element.lecturer == widget.lecturer)
                  .map(
                    (e) => DataRow(cells: [
                      DataCell(Container(
                        width: 300,
                        child: Text(
                          e.subject,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      )),
                      DataCell(Container(
                        width: 200,
                        child: Text(
                          e.group.toString(),
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      )),
                      DataCell(Container(
                        width: 100,
                        child: Text(
                          e.assignedClassroom,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      )),
                      DataCell(Container(
                        width: 200,
                        child: Text(
                          e.getDays.toString(),
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      )),
                      DataCell(Container(
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
    );
  }
}
