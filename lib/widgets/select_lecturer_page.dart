import 'dart:convert';

import 'package:editable/editable.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:timetabling/models/myData.dart';
import 'package:timetabling/models/myData2.dart';
import 'package:timetabling/models/subject.dart';
import 'package:provider/provider.dart';
import 'package:timetabling/models/input_subject_state.dart';
import '../models/classes.dart';
import '../models/classrooms.dart';
import '../shared/collapsing_navigation_drawer.dart';

class SelectLecturerInputPage extends StatefulWidget {
  final List<Classes> allClasses;

  const SelectLecturerInputPage({Key? key, required this.allClasses})
      : super(key: key);

  @override
  State<SelectLecturerInputPage> createState() =>
      _SelectLecturerInputPageState();
}

class _SelectLecturerInputPageState extends State<SelectLecturerInputPage> {
  Classrooms? classrooms;
  List headers = [
    {'title': 'Lecturer', 'index': 4, 'key': 'Lecturer'},
    {'title': 'Name', 'index': 1, 'key': 'Subject'},
    {'title': 'Type', 'index': 2, 'key': 'Type'},
    {'title': 'Level', 'index': 3, 'key': 'Level'},
    {'title': 'Department', 'index': 4, 'key': 'for'},
    {'title': 'Capacity', 'index': 4, 'key': 'Classroom'},
    {'title': 'Classroom', 'index': 4, 'key': 'Duration'},
    {'title': 'Duration', 'index': 4, 'key': 'Capacity'},
  ];

  // Future<List<Classes>> getClasses() async {
  //   return widget.allClasses;
  // }

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<InputSubjectsState>(context, listen: false);
    final DataTableSource _data = MyData2(provider.multipleLecturers, provider);
    //provider.allClasses.isEmpty
    //    ? const Center(child: Text('No Data'))
    ///     :
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: PaginatedDataTable(
          header: const Text('Input Data'),
          showCheckboxColumn: true,
          //   columnSpacing: 56,
          columnSpacing: 5,
          showFirstLastButtons: true,
          dragStartBehavior: DragStartBehavior.down,
          actions: [
            IconButton(
              splashColor: Colors.transparent,
              icon: const Icon(Icons.refresh),
              onPressed: () {
                setState(() {});
              },
            ),
            ElevatedButton(
              child: const Text('Confirm All'),
              onPressed: () {
                provider.deleteAll();
              },
            ),
          ],
          source: _data,
          columns: const [
            DataColumn(label: Text("Num"), tooltip: 'Num'),
            DataColumn(label: Text("Lecturer"), tooltip: 'Lecturer'),
            DataColumn(label: Text("Name"), tooltip: 'Name'),
            DataColumn(label: Text("Type"), tooltip: 'Type'),
            DataColumn(
              label: Text("Level"),
              numeric: true,
              tooltip: 'Level',
            ),
            DataColumn(label: Text("Department"), tooltip: 'Department'),
            DataColumn(label: Text("Capacity"), tooltip: 'Capacity'),
            DataColumn(label: Text("ClassRoom"), tooltip: 'ClassRoom'),
            DataColumn(label: Text("Duration"), tooltip: 'Duration'),
            DataColumn(label: Text("Delete"), tooltip: 'Delete'),
          ],
        ),
      ),
    );
  }
}
